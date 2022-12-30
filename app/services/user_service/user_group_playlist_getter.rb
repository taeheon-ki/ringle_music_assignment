module UserService
    class UserGroupPlaylistGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @group_id = args[:group_id]
        end

        def call
            user_liked_list = GroupPlaylistMusic.includes(:music).where(user_id: @user_id)
            user_liked_list.map(&:as_music_json)
        end
    end
end