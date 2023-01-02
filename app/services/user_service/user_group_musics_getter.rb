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
    end
end