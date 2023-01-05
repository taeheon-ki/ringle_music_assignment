module Groups
    class ChangeGroupnameService < ApplicationService
        def initialize(current_user, group_name, group_id)
            @current_user = current_user
            @group_name = group_name
            @group_id = group_id
        end

        def call

            raise ActiveRecord::RecordNotFound unless group = Group.find_by(id: @group_id, user_id: @current_user.id)
            group.change_name!(group_name: @group_name)

        end
    end
end