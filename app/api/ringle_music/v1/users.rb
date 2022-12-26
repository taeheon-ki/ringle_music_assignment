module RingleMusic
    module V1
      class Users < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api

        resource :users do
            desc 'Return list of songs'
            get do
                user = User.all
                present user
            end
        end
      end
    end
  end