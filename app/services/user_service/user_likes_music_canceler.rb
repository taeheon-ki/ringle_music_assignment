module UserService
    class UserLikesMusicCanceler < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @music_id = args[:music_id]
        end

        def call
            begin
                destroy_music = UserLikesMusic.find_by(user_id: @user_id, music_id: @music_id)
                if destroy_music.nil?
                    return {success: false, message: "User is not liking this music"}
                end
                destroy_music.destroy
                return {success: true}
            rescue => e
                return {success: false, message: e.message}
            end
        end
    end
end