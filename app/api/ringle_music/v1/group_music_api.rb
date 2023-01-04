module RingleMusic
    module V1
        class GroupMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :group_musics do

                

                route_param :group_id, type: Integer do

                    get do
                        authenticate!
                        begin
                            GroupMusicService::GroupMusicsGetter.call(current_user, params[:group_id])
                        rescue => e
                            error!({ message: e.message })
                        end
    
                    end
                    desc 'add music to playlist for group'
                    params do
                        requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                    end
                    post do
                        authenticate!
                        begin
                            GroupMusicService::GroupMusicsAdder.call(current_user, params[:group_id], params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            error!({ message: "Group Not Found" })
                        rescue => e
                            error!({ message: e.message })
                        end

                    end
                    desc 'destroy music in playlist of group'
                    params do
                        requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                    end
                    delete do
                        authenticate!
                        begin
                            GroupMusicService::GroupMusicsDestroyer.call(current_user, params[:group_id], params[:music_ids])
                        rescue ActiveRecord::RecordNotFound => e
                            error!({ message: "Group Not Found" })
                        rescue => e
                            error!({ message: e.message })
                        end

                    end
                end
            end
        end
    end
end
