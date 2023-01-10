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
                    "SOUNDEX(title) = SOUNDEX(:query) OR title LIKE :like_query OR
                    SOUNDEX(artist) = SOUNDEX(:query) OR artist LIKE :like_query OR
                    SOUNDEX(album) = SOUNDEX(:query) OR album LIKE :like_query",
                    query: @query, like_query: "%#{@query}%")
                musics = sort(musics)
            else
                musics = Music.order(user_likes_musics_count: :desc).take(@limit) if @sort == 'likes'
                musics = Music.order(created_at: :desc).take(@limit) if @sort == 'created_at'
                musics = Music.limit(@limit) if @sort != 'created_at' && @sort != 'likes'
            end
            
            
            return musics
        end
    
        def sort(musics)
            case @sort
            when 'accuracy'
                if @query.present?
                    musics = musics.sort_by do |music|
                        [-String::Similarity.cosine(music.title, @query),
                        -String::Similarity.cosine(music.artist, @query),
                        -String::Similarity.cosine(music.album, @query)]
                    end
                    
                end
                musics = musics.take(@limit)
            when 'likes'
                musics = musics.order(user_likes_musics_count: :desc).take(@limit)
            when 'created_at'
                musics = musics.order(created_at: :desc).take(@limit)
            else
                musics = musics.take(@limit)
            end
            musics
        end
    end
end