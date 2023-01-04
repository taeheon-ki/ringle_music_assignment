module UserGroupService
    class UserGroupsGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call
            

            user_groups = UserGroup.where(user_id: @current_user.id)


        end
    end
end