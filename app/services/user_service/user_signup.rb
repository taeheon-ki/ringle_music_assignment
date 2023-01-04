module UserService
    class UserSignup < ApplicationService
        class ValidationError < StandardError; end
        def initialize(args)
            @user_name = args[:user_name]
            @email = args[:email]
            @password = args[:password]
        end

        def call
            user = User.find_by(email: @email)
            raise ValidationError, "User Email Not Usable" if user
            
            user = User.create!({
                user_name: @user_name,
                email: @email,
                password: @password
            })
        
            return {
                success: true,
                user: user,
            }
        end
    end
end