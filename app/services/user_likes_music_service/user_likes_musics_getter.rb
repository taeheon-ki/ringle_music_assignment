module UserLikesMusicService
    class UserLikesMusicsGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call
            
            user_liked_list = UserLikesMusic.where(user_id: @current_user.id)
            user_liked_list.map(&:as_json_of_music)
        end
    end
end