module UserLikesMusics
    class CancelUserLikesMusicService < ApplicationService
        def initialize(current_user, music_id)
            @current_user = current_user
            @music_id = music_id
        end

        def call
            

            destroy_music = UserLikesMusic.find_by(user_id: @current_user.id, music_id: @music_id)

            raise ActiveRecord::RecordNotFound if destroy_music.nil?

            destroy_music.destroy!
            return {success: true}

        end
    end
end