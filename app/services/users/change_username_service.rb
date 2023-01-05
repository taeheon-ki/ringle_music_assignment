module Users
    class ChangeUsernameService < ApplicationService
        def initialize(current_user, user_name)
            @current_user = current_user
            @user_name = user_name
        end

        def call

            @current_user.change_name!(user_name: @user_name)

        end
    end
end