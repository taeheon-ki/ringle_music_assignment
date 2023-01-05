module GroupService
    class GroupCreater < ApplicationService
        def initialize(current_user, group_name)
            @current_user = current_user
            @group_name = group_name
        end

        def call

            Group.create!(user_id: @current_user.id, group_name: @group_name)
            return {success: true, created_group: @group_name, made_user: Entities::UserEntity.represent(@current_user)}

        end
    end
end