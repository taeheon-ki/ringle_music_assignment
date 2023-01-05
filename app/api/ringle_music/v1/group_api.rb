module RingleMusic
    module V1
        class GroupApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :groups do

                desc 'Create group'
                params do
                    requires :group_name, values: {proc: ->(group_name) {group_name!=""}}
                end
                post do
                    authenticate!
                    begin

                        GroupService::GroupCreater.call(current_user, params[:group_name])
                        return {success: true, created_group: params[:group_name], made_user: Entities::UserEntity.represent(current_user)}

                    rescue => e
                        return {success: false, message: e.message}
                    end
                end

                desc 'List group'
                get do

                    groups = GroupService::GroupsGetter.call()
                    present groups, with: Entities::GroupEntity
                end

                route_param :group_id do

                    params do
                        requires :group_name, type: String
                        requires :password, type: String
                    end
                    patch :group_name do
                        authenticate_with_password!(params[:password])
                        begin
                            GroupService::ChangeGroupname.call(current_user, params[:group_name], params[:group_id])
                            return {success: true}
                        rescue ActiveRecord::RecordNotFound => e
                            return {success: false, message: "Cannot Modify Group Name"}
                        rescue => e
                            return {success: false, message: e.message}
                        end
                    end

                    delete do
                        authenticate!
                        begin
                            GroupService::GroupDestroyer.call(current_user, params[:group_id])
                        rescue ActiveRecord::RecordNotFound => e
                            { success: false, message: "User Not Added This Group!" }
                        rescue => e
                            { success: false, message: e.message }
                        end
                    end

                    resource :musics do
                        get do
                            authenticate!
                            begin
                                GroupMusicService::GroupMusicsGetter.call(current_user, params[:group_id])
                            rescue ActiveRecord::RecordNotFound => e
                                { success: false, message: "Group Not Found" }
                            rescue => e
                                { success: false, message: e.message }
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
                                { success: false, message: "Group Not Found" }
                            rescue => e
                                { success: false, message: e.message }
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
                                { success: false, message: "Group Not Found" }
                            rescue => e
                                { success: false, message: e.message }
                            end
                        end
                    end
                end
            end
        end
    end
end
