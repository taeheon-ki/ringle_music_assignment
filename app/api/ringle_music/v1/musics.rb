module RingleMusic
    module V1
      class Musics < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api

        resource :musics do
            desc 'Return list of songs'
            get do
              # Return all musics if no parameters are specified
              musics = Music.all
              musics = musics.as_json(only: [:title, :artist, :album, :likes_count])
              present musics
            end
          
            desc 'Search and sort musics'
            params do
              optional :q, type: String, desc: 'Search term'
              optional :sort, type: String, desc: 'Sort criteria (accuracy, likes, created_date)'
            end
            get :search do
              # Search for musics by title, artist, or album
              musics = Music.all
              musics = musics.where("title LIKE ? OR artist LIKE ? OR album LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
          
              # Sort musics by accuracy of searching string, likes, or created_date
              case params[:sort]
              when "accuracy"
                musics = musics.order(title: :desc)
                musics = musics.order(artist: :desc)
                musics = musics.order(album: :desc)
              when "likes"
                musics = musics.order(likes_count: :desc)
              when "created_date"
                musics = musics.order(created_at: :desc)
              end
              musics = musics.as_json(only: [:title, :artist, :album, :likes_count])
              present musics
            end
        end
      end
    end
end
