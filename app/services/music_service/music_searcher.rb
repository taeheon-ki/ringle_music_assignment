module MusicService
    class MusicSearcher < ApplicationService
        def initialize(args)
            @query = args[:query].downcase
            @sort = args[:sort]
        end
    
        def call
            
            musics = Music.all
            musics = musics.select do |music|
                
                String::Similarity.levenshtein_distance(music.title, @query) <= 2 ||
                String::Similarity.levenshtein_distance(music.artist, @query) <= 2 ||
                String::Similarity.levenshtein_distance(music.album, @query) <= 2 ||
                music.title.downcase.include?(@query) || music.artist.downcase.include?(@query) || music.album.downcase.include?(@query)
            end if @query.present?
            
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
                    [-music.user_likes_musics_count,
                    -String::Similarity.cosine(music.title, @query),
                    -String::Similarity.cosine(music.artist, @query),
                    -String::Similarity.cosine(music.album, @query)]
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