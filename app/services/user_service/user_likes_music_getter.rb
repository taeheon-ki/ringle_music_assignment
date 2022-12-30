module UserService
    class UserLikesMusicGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user_liked_list = UserLikesMusic.includes(:music).where(user_id: @user_id)
            user_liked_list.map(&:as_json)
        end
    end
end