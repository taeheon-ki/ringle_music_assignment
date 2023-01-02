module UserService
    class UserGroupJoiner < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end

        def call
            do_authorization
            begin
                if !Group.exists?(@group_id)
                    return {success:false, message: "Group not exists"}
                end
                UserGroup.create!({user_id: @user_id, group_id: @group_id})
                return {success: true}
            rescue => e
                return {success: false, message: e.message}
            end
        end
    end
end