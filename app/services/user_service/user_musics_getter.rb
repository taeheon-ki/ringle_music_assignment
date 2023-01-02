module UserService
    class UserMusicsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            do_authorization
            user_liked_list = UserMusic.includes(:music).where(user_id: @user_id)
            user_liked_list.map(&:as_json_of_music)
        end
    end
end