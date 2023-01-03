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
                    begin
                        UserGroupService::UserGroupJoiner.call(request: request, group_id: params[:group_id])
                    rescue => e
                        return {success: false, message: e.message}
                    end

                    return {success: true}

                end


                desc 'exit group'
                params do
                    requires :group_id
                end
                delete do

                    begin
                        UserGroupService::UserGroupExiter.call(request: request, group_id: params[:group_id])
                    rescue ActiveRecord::RecordNotFound => e
                        return {success: false, message: "UserGroup Not Found"}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    
                    return {success: true}

                end     
            end
        end
    end
end
