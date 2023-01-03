module UserGroupService
    class UserGroupJoiner < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result

            if !Group.exists?(@group_id)
                return {success:false, message: "Group not exists"}
            end
            
            UserGroup.create!({user_id: @user_id, group_id: @group_id})

        end
    end
end