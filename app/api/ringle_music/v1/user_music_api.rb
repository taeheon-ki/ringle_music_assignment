module RingleMusic
    module V1
        class UserMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :user_musics do
                desc 'add music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post do
                    authenticate!
                    begin
                        UserMusicService::UserMusicsAdder.call(current_user, params[:music_ids])
                    rescue ActiveRecord::RecordNotFound => e
                        error!({ message: "User Not Found" })
                    rescue => e
                        error!({ message: e.message })
                    end
                end

                desc 'delete music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end

                delete do
                    authenticate!
                    begin
                        UserMusicService::UserMusicsDestroyer.call(current_user, params[:music_ids])
                    rescue ActiveRecord::RecordNotFound => e
                        error!({ message: "User Not Found" })
                    rescue => e
                        error!({ message: e.message })
                    end

                end

                desc 'get playlist of user'
                get do
                    authenticate!


                    musics = UserMusicService::UserMusicsGetter.call(request: request)
                    present musics, with: Entities::MusicEntity


                end
            end

            
        end
    end
end
