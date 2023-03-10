module Groups
    class CreateGroupService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @group_name = args[:group_name]
        end

        def call

            group = Group.create!(user_id: @current_user.id, group_name: @group_name)
            return {success: true, group_id: group.id, created_group: @group_name, made_user: Entities::UserEntity.represent(@current_user)}

        end
    end
end