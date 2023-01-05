module UserService
    class UserSignin < ApplicationService
        class ValidationError < StandardError; end
        def initialize(args)
            @email = args[:email]
            @password = args[:password]
        end

        def call
            user = User.find_by(email: @email)
            raise ValidationError, "User Not Exists" if user.nil?

            is_valid = user.valid_password?(@password)
            raise ValidationError, "Password is not Valid" unless is_valid

            jwt_token = User.create_jwt_token(user.id)

            return {
                success: true,
                message: "valid",
                jwt_token: jwt_token,
            }

        end
    end
end