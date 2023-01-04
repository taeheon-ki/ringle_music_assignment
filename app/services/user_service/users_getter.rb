module UserService
    class UsersGetter < ApplicationService


        def call

            users = User.all

        end
    end
end