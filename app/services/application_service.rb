class ApplicationService
    def self.call(*args)

        new(*args).call
        
    end

    def do_authorization
        auth_result = AuthService::Authorizer.call(request: @request)
        return auth_result if auth_result.is_a?(Hash)
        @user_id = auth_result
    end

    def group_exist_validation
        unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)
            return {success: false, message: "user is not existing in group"}
        end
    end
    
end