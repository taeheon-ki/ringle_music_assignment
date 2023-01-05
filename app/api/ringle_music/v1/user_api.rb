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
                    requires :user_name, type: String, values: {proc: ->(user_name) {user_name!=""}}
                    requires :email, type: String, values: {proc: ->(email) {email!=""}}
                    requires :password, type: String, values: {proc: ->(password) {password!=""}}
                end
                post "signup" do
                    begin

                        UserService::UserSignup.call(user_name: params[:user_name], email: params[:email], password: params[:password])
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
                post "signin" do
                    begin
                        UserService::UserSignin.call(params.symbolize_keys)
                    rescue UserService::UserSignin::ValidationError => e
                        return {success: false, ErrorType: "ValidationError", message: e.message}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    
                end
            end
        end
    end
end