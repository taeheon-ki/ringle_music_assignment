module Groups
    class GetGroupsService < ApplicationService
        def initialize(**args)
            @query = args[:query] if args.key?(:query)
        end

        def call
            groups = Group.all
            groups = groups.where(
                "group_name LIKE :like_query ",
                like_query: "%#{@query}%") if @query
            groups

        end
    end
end