module UserService
    class UserGroupsGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user_groups = UserGroup.where(user_id: @user_id)
            user_groups.map(&:as_json_of_group)
        end
    end
end