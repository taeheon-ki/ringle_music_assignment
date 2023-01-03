module UserLikesMusicService
    class UserLikesMusicsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            
            music_list = Music.joins(:user_likes_musics).where('user_likes_musics.user_id = ?', @user_id)
        end
    end
end