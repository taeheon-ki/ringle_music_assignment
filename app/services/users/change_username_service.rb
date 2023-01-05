module Users
    class ChangeUsernameService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @user_name = args[:user_name]
        end

        def call

            @current_user.change_name!(user_name: @user_name)

        end
    end
end