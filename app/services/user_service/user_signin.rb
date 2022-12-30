module UserService
    class UserSignin < ApplicationService
        def initialize(args)
            @email = args[:email]
            @password = args[:password]
        end

        def call
            user = User.find_by(email: @email)
            if user.nil?
                return {
                success: false,
                message: "User not found",
                }
            end
            is_valid = user.valid_password?(@password)
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