module RingleMusic
    module V1
        class MusicApi < Grape::API
            require 'string/similarity'
            version 'v1', using: :path
            format :json
            prefix :api

            resource :musics do
                desc 'Search and sort musics'
                params do
                    optional :query, type: String, desc: 'Search term'
                    optional :sort, type: String, desc: 'Sort criteria (accuracy, likes, created_date)', default: "accuracy"
                end
                get do

                    musics = MusicService::MusicSearcher.call(query: params[:query], sort: params[:sort])
                    musics = musics.as_json(only: [:title, :artist, :album, :user_likes_musics_count])
                    present musics

                end
            end
        end
    end
end
