module UserLikesMusics
    class GetUserLikesMusicsService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @query = args[:query] if args.key?(:query)
        end

        def call
            

            music_list = Music.joins(:user_likes_musics).where('user_likes_musics.user_id = ?', @current_user.id)
            filtered_musics = music_list.where(
                "title LIKE :like_query OR
                artist LIKE :like_query OR
                album LIKE :like_query",
                like_query: "%#{@query}%")


        end
    end
end