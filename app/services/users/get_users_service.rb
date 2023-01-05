module Users
    class GetUsersService < ApplicationService


        def call

            users = User.all

        end
    end
end