module UserService
    class UserGroupsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            do_authorization
            user_groups = UserGroup.where(user_id: @user_id)
            user_groups.map(&:as_json_of_group)
        end

        private
        def do_authorization
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
        end
    end
end