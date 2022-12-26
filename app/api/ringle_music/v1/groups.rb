module RingleMusic
    module V1
      class Groups < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api

        resource :groups do
            desc 'Return list of songs'
            get do
                group = Group.all
                present group
            end
        end
      end
    end
  end