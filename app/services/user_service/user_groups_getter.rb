module UserService
    class UserGroupsGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user_groups = GroupUser.where(user_id: @user_id)
            return user_groups
        end
    end
end