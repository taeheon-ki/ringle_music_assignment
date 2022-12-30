module UserService
    class UserMusicsGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user_liked_list = UserMusic.includes(:music).where(user_id: @user_id)
            user_liked_list.map(&:as_music_json)
        end
    end
end