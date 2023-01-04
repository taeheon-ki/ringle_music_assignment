module RingleMusic
    module V1
        class GroupApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :groups do

                desc 'Create group'
                params do
                    requires :group_name, values: {proc: ->(group_name) {group_name!=""}}
                end
                post do
                    begin
                        GroupService::GroupCreater.call(params[:group_name])
                    rescue => e
                        return {success: false, message: e.message}
                    end
                end

                desc 'List group'
                get do

                    GroupService::GroupsGetter.call()
                    
                end
            end
        end
    end
end
