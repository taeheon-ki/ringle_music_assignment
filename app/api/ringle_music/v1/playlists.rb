module RingleMusic
    module V1
      class Playlists < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api

        resource :playlists do
            desc 'Return list of songs'
            get do
                playlist = Playlist.all
                present playlist
            end
        end
      end
    end
  end