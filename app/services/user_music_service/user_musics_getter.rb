module UserMusicService
    class UserMusicsGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call

            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            
            music_list = Music.joins(:user_musics).where('user_musics.user_id = ?', @user_id)

        end
        
    end
end