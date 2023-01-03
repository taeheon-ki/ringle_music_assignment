module UserLikesMusicService
    class UserLikesMusicCanceler < ApplicationService
        def initialize(args)
            @request = args[:request]
            @music_id = args[:music_id]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            

            destroy_music = UserLikesMusic.find_by(user_id: @user_id, music_id: @music_id)

            raise ActiveRecord::RecordNotFound if destroy_music.nil?

            destroy_music.destroy!
            return {success: true}

        end
    end
end