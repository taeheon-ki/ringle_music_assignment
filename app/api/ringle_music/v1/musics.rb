module RingleMusic
    module V1
      class Musics < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api

        resource :musics do
            desc 'Return list of songs'
            get do
                Music = Music.all
                present song
            end
        end
      end
    end
  end