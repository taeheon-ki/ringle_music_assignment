module Groups
    class DestroyGroupService < ApplicationService
        def initialize(current_user, group_id)
            @current_user = current_user
            @group_id = group_id
        end

        def call
            
            destroy_group = Group.find_by(user_id: @current_user.id, id: @group_id)

            raise ActiveRecord::RecordNotFound if destroy_group.nil?

            destroy_group.destroy!
            return {success: true}

        end
    end
end