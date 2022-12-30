module UserService
    class UserLikesMusicPoster < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @music_id = args[:music_id]
        end

        def call
            begin
                user_likes_music = UserLikesMusic.create!(user_id: @user_id, music_id: @music_id)
                return {success: true}
            rescue => e
                return {success: false, message: e.message}
            end
        end
    end
end