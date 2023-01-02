module RingleMusic
    module V1
        class UserGroupApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :user_groups do

                get do

                    UserGroupService::UserGroupsGetter.call(request: request)

                end

                desc 'join group'
                params do
                    requires :group_id
                end
                post do

                    UserGroupService::UserGroupJoiner.call(request: request, group_id: params[:group_id])

                end


                desc 'exit group'
                params do
                    requires :group_id
                end
                delete do

                    UserGroupService::UserGroupExiter.call(request: request, group_id: params[:group_id])

                end     
            end
        end
    end
end
