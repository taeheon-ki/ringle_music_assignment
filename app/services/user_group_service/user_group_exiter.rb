module UserGroupService
    class UserGroupExiter < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end
        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result

            group_user = UserGroup.find_by(user_id: @user_id, group_id: @group_id)
            raise ActiveRecord::RecordNotFound if group_user.nil?

            group_user.destroy!
            
        end
    end
end
