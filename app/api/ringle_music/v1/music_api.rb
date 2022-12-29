require_relative '../services/music_search_service'

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
                    optional :q, type: String, desc: 'Search term'
                    optional :sort, type: String, desc: 'Sort criteria (accuracy, likes, created_date)'
                end
                get do
                    # Search for musics by title, artist, or album
                    search_service = MusicSearchService.new
                    musics = search_service.search(params[:q])
                    musics = search_service.sort(musics, params[:sort])
                    musics = musics.as_json(only: [:title, :artist, :album, :user_likes_musics_count])
                    present musics

                end
            end
        end
    end
end
