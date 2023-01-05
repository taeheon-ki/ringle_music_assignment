module UserMusics
    class GetUserMusicsService < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call

            music_list = Music.joins(:user_musics).where('user_musics.user_id = ?', @current_user.id)

        end
        
    end
end