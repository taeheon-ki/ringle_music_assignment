module RingleMusic
    module V1
        class UserMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :user_musics do
                desc 'add music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post do

                    UserMusicService::UserMusicsAdder.call(request: request, music_ids: params[:music_ids])
                end

                desc 'delete music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end

                delete do

                    begin
                        UserMusicService::UserMusicsDestroyer.call(request: request, music_ids: params[:music_ids])
                    rescue ActiveRecord::RecordNotFound => e
                        error!({ message: e.message })
                    rescue => e
                        error!({ message: e.message })
                    end

                end

                desc 'get playlist of user'
                get do

                    UserMusicService::UserMusicsGetter.call(request: request)

                end
            end

            
        end
    end
end
