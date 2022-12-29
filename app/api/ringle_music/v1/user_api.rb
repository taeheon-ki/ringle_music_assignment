require_relative '../services/auth_service'

module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :users do

                desc 'add music to playlist for group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusictogroup do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    unless GroupUser.exists?(user_id: result[:user_id], group_id: params[:group_id])
                        return {success: false, message: "user is not existing in group"}
                    end

                    user_id = auth_result
                    music_ids = params[:music_ids]

                    music_ids.each do |music_id|
                        begin
                        GroupPlaylistMusic.create!({group_id: params[:group_id], music_id: music_id, user_id: user_id})
                        rescue => e
                        end
                    end

                    return {success: true}
                end

                desc 'destroy music in playlist of group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                delete :destroymusicofgroup do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    

                    user_id = auth_result
                    music_ids = params[:music_ids]
                    group_id = params[:group_id]

                    unless GroupUser.exists?(user_id: user_id, group_id: group_id)
                        return {success: false, message: "user is not existing in group"}
                    end

                    music_ids.each do |music_id|
                        begin
                            group_playlist_music = GroupPlaylistMusic.where(group_id: group_id, music_id: music_id)
                            
                            if group_playlist_music.empty?
                                return {
                                    success: false, message: "not existing music.."
                                }
                            end
    
                            group_playlist_music.first.destroy
                        rescue => e
                        end
                    end

                    return {success: true}
                end

                desc 'join group'
                params do
                    requires :group_id
                end
                post :joingroup do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    GroupUser.create!({user_id: user_id, group_id: params[:group_id]})

                    return {success: true}
                end

                desc 'exit group'
                params do
                    requires :group_id
                end
                delete :exitgroup do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    group_user = GroupUser.find_by(user_id: user_id, group_id: params[:group_id])
                    group_user.destroy

                    return {success: true}
                end


                desc 'add music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusic do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    user_id = auth_result
                    music_ids = params[:music_ids]

                    music_ids.each do |music_id|
                        begin
                        UserPlaylistMusic.create!({user_id: user_id, music_id: music_id})
                        rescue => e
                        end
                    end

                    return {success: true}
                end

                desc 'delete music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                delete :destroymusic do
                    auth_service = AuthService.new
                    auth_result = auth_service.authenticate_user(request)
                    if auth_result.is_a?(Hash)
                        return authentication_result
                    end

                    user_id = auth_result
                    music_ids = params[:music_ids]

                    music_ids.each do |music_id|
                        begin
                        user_playlist_music = UserPlaylistMusic.where(user_id: user_id, music_id: music_id)
                        
                        if user_playlist_music.empty?
                            return {
                                success: false, message: "not existing music.."
                            }
                        end

                        user_playlist_music.first.destroy
                        rescue => e
                        end
                    end

                    return {success: true}
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