module Musics
    class SearchMusicsService < ApplicationService
        def initialize(**args)
            @query = args[:query] if args.key?(:query)
            @sort = args[:sort] if args.key?(:sort)
        end
    
        def call
            
            if @query.present?
                musics = Music.where(
                    "SOUNDEX(title) = SOUNDEX(:query) OR title LIKE :like_query OR
                    SOUNDEX(artist) = SOUNDEX(:query) OR artist LIKE :like_query OR
                    SOUNDEX(album) = SOUNDEX(:query) OR album LIKE :like_query",
                    query: @query, like_query: "%#{@query}%")
            else
                musics = Music.all
            end
            
            musics = sort(musics) if @sort.present?
            musics = musics.as_json(only: [:id, :title, :artist, :album, :user_likes_musics_count])
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
            when 'likes'
                musics = musics.sort_by do |music|
                    [-music.user_likes_musics_count]
                end
            when 'created_at'
                musics = musics.sort_by do |music|
                    [music.created_at]
                end.reverse
            end
            musics
        end
    end
end