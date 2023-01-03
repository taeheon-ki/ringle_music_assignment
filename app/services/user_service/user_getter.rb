module UserService
    class UserGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            

            user = User.find(@user_id).as_json(only: [:id, :user_name, :email])

        end
    end
end