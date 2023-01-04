module UserGroupService
    class UserGroupsGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call
            
            user_groups = UserGroup.where(user_id: @current_user.id)
            user_groups.map(&:as_json_of_group)
        end
    end
end