module UserService
    class UserGroupMusicsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end

        def call
            do_authorization
            group_exist_validation
            unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)
                return {success: false, message: "user is not existing in group. Validation Falied!"}
            end
            user_liked_list = GroupMusic.includes(:music).where(user_id: @user_id)
            user_liked_list.map(&:as_json_of_group_music)
        end


        private
        def group_exist_validation
            unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)
                return {success: false, message: "user is not existing in group"}
            end
        end
        
        def do_authorization
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
        end
        
    end
end