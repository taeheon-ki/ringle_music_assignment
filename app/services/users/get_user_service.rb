module Users
    class GetUserService < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call

            @current_user

        end
    end
end