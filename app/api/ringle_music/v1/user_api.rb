module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :users do

                get :info do
                    begin
                        UserService::UserGetter.call(request: request)
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
                    begin
                        UserService::UserSignup.call(user_name: params[:user_name], email: params[:email], password: params[:password])
                    rescue => e
                        return {success: false, message: e.message}
                    end

                end

                params do
                    requires :email, type: String
                    requires :password, type: String
                end
                post "signin" do
                    begin
                        UserService::UserSignin.call(email: params[:email], password: params[:password])
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    
                end
            end
        end
    end
end