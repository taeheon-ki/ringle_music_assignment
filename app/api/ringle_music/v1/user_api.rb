module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :users do
                get do
                    authenticate!

                    users = UserService::UsersGetter.call()
                    present users, with: Entities::UserEntity

                end

                resources :info do
                    get do
                        authenticate!
                        begin
                            user_info = UserService::UserGetter.call(current_user)
                            present user_info, with: Entities::UserEntity
                        rescue ActiveRecord::RecordNotFound => e
                            return {success: false, message: "User Not Found"}
                        rescue => e
                            return {success: false, message: e.message}
                        end
                    end

                    params do
                        requires :user_name, type: String
                        requires :password, type: String
                    end
                    patch :user_name do
                        authenticate_with_password!(params[:password])
                        begin
                            UserService::ChangeUsername.call(current_user, params[:user_name])
                            return {success: true}
                        rescue => e
                            return {success: false, message: e.message}
                        end
                    end
                end
                 
            
                params do 
                    requires :user_name, type: String, values: {proc: ->(user_name) {user_name!=""}}
                    requires :email, type: String, values: {proc: ->(email) {email!=""}}
                    requires :password, type: String, values: {proc: ->(password) {password!=""}}
                end
                post :signup do
                    begin

                        UserService::UserSignup.call(params.symbolize_keys)
                    rescue UserService::UserSignin::ValidationError => e
                        return {success: false, ErrorType: "ValidationError", message: e.message}

                    rescue => e
                        return {success: false, message: e.message}
                    end

                end

                params do
                    requires :email, type: String, values: {proc: ->(email) {email!=""}}
                    requires :password, type: String, values: {proc: ->(password) {password!=""}}
                end
                post :signin do
                    begin
                        UserService::UserSignin.call(params.symbolize_keys)
                    rescue UserService::UserSignin::ValidationError => e
                        return {success: false, ErrorType: "ValidationError", message: e.message}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    
                end

                resource :groups do
                    get do
                        authenticate!
    
                        user_groups = UserGroupService::UserGroupsGetter.call(current_user)
                        present user_groups, with: Entities::UserGroupEntity
    
                    end
    
                    route_param :group_id, type: Integer do
                        desc 'join group'
                        post do
                            authenticate!
                            begin
                                UserGroupService::UserGroupJoiner.call(current_user, params[:group_id])
                            rescue ActiveRecord::RecordNotFound => e
                                return {success: false, message: "UserGroup Not Found"}
                            rescue => e
                                return {success: false, message: e.message}
                            end
    
                            return {success: true}
    
                        end
    
    
                        desc 'exit group'
                        delete do
                            authenticate!
                            begin
                                UserGroupService::UserGroupExiter.call(current_user, params[:group_id])
                            rescue ActiveRecord::RecordNotFound => e
                                return {success: false, message: "UserGroup Not Found"}
                            rescue => e
                                return {success: false, message: e.message}
                            end
                            
                            return {success: true}
    
                        end     
                    end
                end

                resource :musics do
                    desc 'add music to playlist for user'
                    params do
                        requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                    end
                    post do
                        authenticate!
                        begin
                            UserMusicService::UserMusicsAdder.call(current_user, params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            error!({ message: "User Not Found" })
                        rescue => e
                            error!({ message: e.message })
                        end
                    end

                    desc 'delete music to playlist for user'
                    params do
                        requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                    end

                    delete do
                        authenticate!
                        begin
                            UserMusicService::UserMusicsDestroyer.call(current_user, params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            error!({ message: "User Not Found" })
                        rescue => e
                            error!({ message: e.message })
                        end

                    end

                    desc 'get playlist of user'
                    get do
                        authenticate!


                        musics = UserMusicService::UserMusicsGetter.call(current_user)
                        present musics, with: Entities::MusicEntity


                    end
                end

                resource :likes do
                    resource :musics do
                        get do
                            authenticate!

                            musics = UserLikesMusicService::UserLikesMusicsGetter.call(current_user)
                            present musics, with: Entities::MusicEntity
                        end


                        route_param :music_id, type: Integer do
                            delete do
                                authenticate!
            
                                begin
                                    UserLikesMusicService::UserLikesMusicCanceler.call(current_user, params[:music_id])
            
                                rescue ActiveRecord::RecordNotFound => e
                                    return {success: false, message: "User doesn't like Found"}
                                rescue => e
                                    return {success: false, message: e.message}
                                end
                                
            
                            end
        
                            post do
                                authenticate!
                                begin
                                    UserLikesMusicService::UserLikesMusicPoster.call(current_user, params[:music_id])
            
                                rescue => e
                                    return {success: false, message: e.message}
                                end
                                
            
                            end
                        end
                    end

                    
                end
            end
        end
    end
end