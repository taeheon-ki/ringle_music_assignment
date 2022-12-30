module UserService
    class UserLikesMusicsGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user_liked_list = UserLikesMusic.where(user_id: @user_id)
            user_liked_list.map(&:as_json_of_music)
        end
    end
end