module UserService
    class UserGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            do_authorization
            begin
                user = User.find(@user_id).as_json(only: [:id, :user_name, :email])
            rescue => e
                return {success: false, message: "User Not Found"}
            end
        end

        private
        def do_authorization
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
        end
        
    end
end