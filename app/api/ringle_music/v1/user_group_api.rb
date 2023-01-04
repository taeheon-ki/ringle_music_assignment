module RingleMusic
    module V1
        class UserGroupApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :user_groups do

                get do
                    authenticate!

                    UserGroupService::UserGroupsGetter.call(current_user)

                end

                desc 'join group'
                params do
                    requires :group_id
                end
                post do
                    authenticate!
                    begin
                        UserGroupService::UserGroupJoiner.call(current_user, params[:group_id])
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
                    authenticate!
                    begin
                        UserGroupService::UserGroupExiter.call(current_user, params[:group_id])
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
