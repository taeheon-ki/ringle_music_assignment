module UserMusics
    class GetUserMusicsService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @query = args[:query] if args.key?(:query)
        end

        def call

            music_list = Music.joins(:user_musics).where('user_musics.user_id = ?', @current_user.id)
            music_list = music_list.where(
                "title LIKE :like_query OR
                artist LIKE :like_query OR
                album LIKE :like_query",
                like_query: "%#{@query}%") if @query
            music_list

        end
        
    end
end