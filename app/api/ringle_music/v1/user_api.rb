module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :users do

                get :info do
                    authenticate!
                    begin
                        UserService::UserGetter.call(current_user)
                    rescue ActiveRecord::RecordNotFound => e
                        return {success: false, message: "User Not Found"}
                    rescue => e
                        return {success: false, message: e.message}
                    end

                end
                 
            
                params do 
                    requires :user_name, type: String
                    requires :email, type: String 
                    requires :password, type: String
                end
                post "signup" do

                    UserService::UserSignup.call(user_name: params[:user_name], email: params[:email], password: params[:password])

                end

                params do
                    requires :email, type: String
                    requires :password, type: String
                end
                post "signin" do

                    UserService::UserSignin.call(email: params[:email], password: params[:password])
                    
                end
            end
        end
    end
end