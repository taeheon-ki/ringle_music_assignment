module Users
    class GetUsersService < ApplicationService
        def initialize(**args)
            @query = args[:query] if args.key?(:query)
        end

        def call

            users = User.all
            filtered_users = users.where(
                "user_name LIKE :like_query ",
                like_query: "%#{@query}%")

        end
    end
end