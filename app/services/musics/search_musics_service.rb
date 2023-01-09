module Musics
    class SearchMusicsService < ApplicationService
        def initialize(**args)
            @query = args[:query] if args.key?(:query)
            @sort = args[:sort] if args.key?(:sort)
            @limit = args[:limit]
        end
    
        def call
            
            if @query.present?
                musics = Music.where(
                    "title LIKE :like_query OR
                    artist LIKE :like_query OR
                    album LIKE :like_query",
                    query: @query, like_query: "%#{@query}%")
            else
                musics = Music.all
            end
            
            musics = sort(musics) if @sort.present?
            musics = musics.take(@limit)
            musics
            return musics
        end
    
        def sort(musics)
            case @sort
            when 'accuracy'
                if @query.present?
                    musics = musics.order(
                      Arel.sql("SOUNDEX(title) = SOUNDEX(#{@query.inspect}) DESC, SOUNDEX(artist) = SOUNDEX(#{@query.inspect}) DESC, SOUNDEX(album) = SOUNDEX(#{@query.inspect}) DESC")
                    )
                end
            when 'likes'
                musics = musics.order(user_likes_musics_count: :desc)
            when 'created_at'
                musics = musics.order(created_at: :desc)
            end
            musics
        end
    end
end