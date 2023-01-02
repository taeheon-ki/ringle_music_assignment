module RingleMusic
    module V1
        class GroupMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :group_musics do

                params do
                    requires :group_id
                end
                get do

                    GroupMusicService::GroupMusicsGetter.call(request: request, group_id: params[:group_id])

                end

                desc 'add music to playlist for group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post do

                    GroupMusicService::GroupMusicsAdder.call(request: request, group_id: params[:group_id], music_ids: params[:music_ids])

                end

                desc 'destroy music in playlist of group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                delete do

                    GroupMusicService::GroupMusicsDestroyer.call(request: request, group_id: params[:group_id], music_ids: params[:music_ids])

                end
            end
        end
    end
end
