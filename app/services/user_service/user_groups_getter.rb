module UserService
    class UserGroupsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            do_authorization
            user_groups = UserGroup.where(user_id: @user_id)
            user_groups.map(&:as_json_of_group)
        end
    end
end