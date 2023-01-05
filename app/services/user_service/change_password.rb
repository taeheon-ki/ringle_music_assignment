module UserService
    class ChangePassword < ApplicationService
        def initialize(current_user, new_password)
            @current_user = current_user
            @new_password = new_password
        end

        def call
            @current_user.change_password!(password: @new_password)
        end
    end
end