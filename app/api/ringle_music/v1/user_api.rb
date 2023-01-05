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

                    users = Users::GetUsersService.call()
                    present users, with: Entities::UserEntity

                end

                resources :info do
                    get do
                        authenticate!
                        begin
                            user_info = Users::GetUserService.call(current_user)
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
                            Users::ChangeUsernameService.call(current_user, params[:user_name])
                            return {success: true}
                        rescue => e
                            return {success: false, message: e.message}
                        end
                    end

                    params do
                        requires :new_password, type: String
                        requires :old_password, type: String
                    end
                    patch :password do
                        authenticate_with_password!(params[:old_password])
                        begin
                            Users::ChangePasswordService.call(current_user, params[:new_password])
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

                        Users::SignupUserService.call(params.symbolize_keys)
                    rescue Users::SigninUserService::ValidationError => e
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
                        Users::SigninUserService.call(params.symbolize_keys)
                    rescue Users::SigninUserService::ValidationError => e
                        return {success: false, ErrorType: "ValidationError", message: e.message}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    
                end

                resource :groups do
                    get do
                        authenticate!
    
                        user_groups = UserGroups::GetUserGroupService.call(current_user)
                        present user_groups, with: Entities::UserGroupEntity
    
                    end
    
                    route_param :group_id, type: Integer do
                        desc 'join group'
                        post do
                            authenticate!
                            begin
                                UserGroups::JoinUserGroupService.call(current_user, params[:group_id])
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
                                UserGroups::ExitUserGroupService.call(current_user, params[:group_id])
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
                            UserMusics::AddUserMusicsService.call(current_user, params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            return {success: false, message: "User Not Found" }
                        rescue => e
                            return { success: fakse, message: e.message }
                        end
                    end

                    desc 'delete music to playlist for user'
                    params do
                        requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                    end

                    delete do
                        authenticate!
                        begin
                            UserMusics::DestroyUserMusicsService.call(current_user, params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            { success: false, message: "User Not Found" }
                        rescue => e
                            { success: false, message: e.message }
                        end

                    end

                    desc 'get playlist of user'
                    get do
                        authenticate!


                        musics = UserMusics::GetUserMusicsService.call(current_user)
                        present musics, with: Entities::MusicEntity


                    end
                end

                resource :likes do
                    resource :musics do
                        get do
                            authenticate!

                            musics = UserLikesMusics::GetUserLikesMusicsService.call(current_user)
                            present musics, with: Entities::MusicEntity
                        end


                        route_param :music_id, type: Integer do
                            delete do
                                authenticate!
            
                                begin
                                    UserLikesMusics::CancelUserLikesMusicService.call(current_user, params[:music_id])
            
                                rescue ActiveRecord::RecordNotFound => e
                                    return {success: false, message: "User doesn't like Found"}
                                rescue => e
                                    return {success: false, message: e.message}
                                end
                                
            
                            end
        
                            post do
                                authenticate!
                                begin
                                    UserLikesMusics::PostUserLikesMusicService.call(current_user, params[:music_id])
            
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