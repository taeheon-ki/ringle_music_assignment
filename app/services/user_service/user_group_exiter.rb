module UserService
    class UserGroupExiter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @group_id = args[:group_id]
        end
        def call

            group_user = GroupUser.find_by(user_id: @user_id, group_id: @group_id)
            if group_user.nil?
                return {success: false, message: "Group user not found"}
            else
                group_user.destroy
                return {success: true}
            end


        end
    end
end
