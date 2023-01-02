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
    end
end