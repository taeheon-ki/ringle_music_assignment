module UserService
    class UserSignin < ApplicationService
        def initialize(args)
            @email = args[:email]
            @password = args[:password]
        end

        def call
            user = User.find_by(email: @email)
            raise StandardError, "User Not Exists" if user.nil?

            is_valid = user.valid_password?(@password)
            raise StandardError, "User is not Valid" unless is_valid

            jwt_token = User.create_jwt_token(user.id)

            return {
                success: true,
                message: "valid",
                jwt_token: jwt_token,
            }

        end
    end
end