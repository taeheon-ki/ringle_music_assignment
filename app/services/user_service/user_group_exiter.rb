module UserService
    class UserGroupExiter < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end
        def call
            do_authorization

            group_user = UserGroup.find_by(user_id: @user_id, group_id: @group_id)
            if group_user.nil?
                return {success: false, message: "User is not a member of group"}
            else
                group_user.destroy
                return {success: true}
            end
        end
    end
end
