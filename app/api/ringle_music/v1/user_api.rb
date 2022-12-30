module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :users do

                get :usergroups do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserGroupsGetter.call(user_id: user_id)
                end

                params do
                    requires :music_id
                end
                delete :canceltolikemusic do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserLikesMusicCanceler.call(user_id: user_id, music_id: params[:music_id])
                end

                params do
                    requires :music_id
                end
                post :likesmusic do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserLikesMusicPoster.call(user_id: user_id, music_id: params[:music_id])
                end

                desc 'list of musics that user likes'
                get :likedmusics do

                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    user_liked_list = UserService::UserLikesMusicsGetter.call(user_id: user_id)

                end

                desc 'get playlist of user'
                get :playlist do

                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    playlist = UserService::UserMusicsGetter.call(user_id: user_id)

                end

                desc 'get group playlist which user joined'
                params do
                    requires :group_id
                end
                get :groupplaylist do
                    
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    unless UserGroup.exists?(user_id: user_id, group_id: params[:group_id])
                        return {success: false, message: "user is not existing in group. Validation Falied!"}
                    end

                    playlist = UserService::UserGroupMusicsGetter.call(user_id: user_id, group_id: params[:group_id])

                end

                desc 'add music to playlist for group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusicstogroup do
                    
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    unless UserGroup.exists?(user_id: user_id, group_id: params[:group_id])
                        return {success: false, message: "user is not existing in group"}
                    end

                    UserService::UserGroupMusicsAdder.call(user_id: user_id, group_id: params[:group_id], music_ids: params[:music_ids])

                end

                desc 'destroy music in playlist of group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                delete :destroymusicofgroup do

                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    unless UserGroup.exists?(user_id: user_id, group_id: params[:group_id])
                        return {success: false, message: "user is not existing in group"}
                    end

                    UserService::UserGroupMusicsDestroyer.call(user_id: user_id, group_id: params[:group_id], music_ids: params[:music_ids])


                end

                desc 'join group'
                params do
                    requires :group_id
                end
                post :joingroup do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserGroupJoiner.call(user_id: user_id, group_id: params[:group_id])

                end

                desc 'exit group'
                params do
                    requires :group_id
                end
                delete :exitgroup do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserGroupExiter.call(user_id: user_id, group_id: params[:group_id])

                end


                desc 'add music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusic do

                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserMusicsAdder.call(user_id: user_id, music_ids: params[:music_ids])

                end

                desc 'delete music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end

                delete :destroymusic do
                    auth_result = AuthService::Authorizer.call(request: request)
                    return auth_result if auth_result.is_a?(Hash)
                    user_id = auth_result

                    UserService::UserMusicsDestroyer.call(user_id: user_id, music_ids: params[:music_ids])

                end

                
            
                params do 
                    requires :user_name, type: String
                    requires :email, type: String 
                    requires :password, type: String
                end
                post "signup" do
                    user = User.find_by(email: params[:email])
                    if user 
                        return {
                            success: false,
                            message: "User Email Not Usable"
                        }
                    end
                    
                    user = User.create!({
                        user_name: params[:user_name],
                        email: params[:email],
                        password: params[:password]	
                    })
                
                    return {
                        success: true,
                        user: user,
                    }
                end

                params do
                    requires :email, type: String
                    requires :password, type: String
                end
                post "signin" do
                    user = User.find_by(email: params[:email])
                    if user.nil?
                        return {
                          success: false,
                          message: "User not found",
                        }
                      end
                    is_valid = user.valid_password?(params[:password])
                    unless is_valid
                        return {
                            success: false,
                            message: "not valid",
                        }
                    end

                    jwt_token = User.create_jwt_token(user.id)

                    return {
                        success: true,
                        message: "valid",
                        jwt_token: jwt_token,
                    }
                    
                end
            end
        end
    end
end