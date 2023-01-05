module UserLikesMusics
    class PostUserLikesMusicService < ApplicationService
        def initialize(current_user, music_id)
            @current_user = current_user
            @music_id = music_id
        end

        def call

            user_likes_music = UserLikesMusic.create!(user_id: @current_user.id, music_id: @music_id)
            return {success: true}

        end
    end
end