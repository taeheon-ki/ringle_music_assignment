module RingleMusic
    module V1
        class Musics < Grape::API
            require 'string/similarity'
            version 'v1', using: :path
            format :json
            prefix :api

            resource :musics do
            
                desc 'Search and sort musics'
                params do
                    optional :q, type: String, desc: 'Search term'
                    optional :sort, type: String, desc: 'Sort criteria (accuracy, likes, created_date)'
                end
                get do
                    # Search for musics by title, artist, or album
                    musics = Music.all
                    if params[:q].present?
                        musics = musics.select do |music|
                            String::Similarity.levenshtein_distance(music.title, params[:q]) <= 2 ||
                            String::Similarity.levenshtein_distance(music.artist, params[:q]) <= 2 ||
                            String::Similarity.levenshtein_distance(music.album, params[:q]) <= 2
                        end
                    end
                # Sort musics by accuracy of searching string, likes, or created_date
                    case params[:sort]
                    when "accuracy"
                        if params[:q].present?
                            musics = musics.sort_by do |music|
                                [-String::Similarity.cosine(music.title, params[:q]),
                                -String::Similarity.cosine(music.artist, params[:q]),
                                -String::Similarity.cosine(music.album, params[:q])]
                            end
                        end
                    when "likes"
                        musics = musics.sort_by do |music|
                            [music.user_likes_musics_count]
                        end.reverse
                    when "created_at"
                        musics = musics.sort_by do |music|
                            [music.created_at]
                        end.reverse
                    end
                    musics = musics.as_json(only: [:title, :artist, :album, :user_likes_musics_count])
                    present musics
                end
            end
        end
    end
end
