class MusicSearchService
    def search(query)
      musics = Music.all
      if query.present?
        musics = musics.select do |music|
          String::Similarity.levenshtein_distance(music.title, query) <= 2 ||
            String::Similarity.levenshtein_distance(music.artist, query) <= 2 ||
            String::Similarity.levenshtein_distance(music.album, query) <= 2
        end
      end
      musics
    end
  
    def sort(musics, criteria)
      case criteria
      when 'accuracy'
        if query.present?
          musics = musics.sort_by do |music|
            [-String::Similarity.cosine(music.title, query),
             -String::Similarity.cosine(music.artist, query),
             -String::Similarity.cosine(music.album, query)]
          end
        end
      when 'likes'
        musics = musics.sort_by do |music|
          [music.user_likes_musics_count]
        end.reverse
      when 'created_at'
        musics = musics.sort_by do |music|
          [music.created_at]
        end.reverse
      end
      musics
    end
  end