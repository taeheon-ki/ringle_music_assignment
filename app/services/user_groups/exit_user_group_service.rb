module UserGroups
    class ExitUserGroupService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @group_id = args[:group_id]
        end
        def call

            group_user = UserGroup.find_by(user_id: @current_user.id, group_id: @group_id)
            raise ActiveRecord::RecordNotFound if group_user.nil?

            group_user.destroy!
            
        end
    end
end
