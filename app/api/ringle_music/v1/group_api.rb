module RingleMusic
    module V1
        class GroupApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :groups do

                desc 'Create group'
                params do
                    requires :group_name
                end
                post do

                    GroupService::GroupCreater.call(group_name: params[:group_name])

                end

                desc 'List group'
                get do

                    GroupService::GroupsGetter.call()
                    
                end
            end
        end
    end
end
