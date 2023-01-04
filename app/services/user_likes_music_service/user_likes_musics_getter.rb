module UserLikesMusicService
    class UserLikesMusicsGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call
            

            music_list = Music.joins(:user_likes_musics).where('user_likes_musics.user_id = ?', @current_user.id)

        end
    end
end