module UserLikesMusicService
    class UserLikesMusicPoster < ApplicationService
        def initialize(args)
            @request = args[:request]
            @music_id = args[:music_id]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result


            user_likes_music = UserLikesMusic.create!(user_id: @user_id, music_id: @music_id)
            return {success: true}

        end
    end
end