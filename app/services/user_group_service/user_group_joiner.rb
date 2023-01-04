module UserGroupService
    class UserGroupJoiner < ApplicationService
        def initialize(current_user, group_id)
            @current_user = current_user
            @group_id = group_id
        end

        def call

            if !Group.exists?(@group_id)
                return {success:false, message: "Group not exists"}
            end
            
            UserGroup.create!({user_id: @current_user.id, group_id: @group_id})

        end
    end
end