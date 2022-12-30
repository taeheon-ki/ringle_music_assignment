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

                    MusicService::MusicSearcher.call(query: params[:query], sort: params[:sort])

                end
            end
        end
    end
end
