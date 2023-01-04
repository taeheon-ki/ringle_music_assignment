module GroupMusicService
    class GroupMusicsGetter < ApplicationService
        def initialize(current_user, group_id)
            @current_user = current_user
            @group_id = group_id
        end

        def call

            unless UserGroup.exists?(user_id: @current_user.id, group_id: @group_id)
                return {success: false, message: "user is not existing in group"}
            end
            
            user_liked_list = GroupMusic.includes(:music).where(user_id: @current_user.id)
            user_liked_list.map(&:as_json_of_group_music)
        end
    end
end