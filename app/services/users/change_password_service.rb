module Users
    class ChangePasswordService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @new_password = args[:new_password]
        end

        def call
            @current_user.change_password!(password: @new_password)
        end
    end
end