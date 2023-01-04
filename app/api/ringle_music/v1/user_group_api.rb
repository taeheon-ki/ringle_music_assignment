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

                    user_groups = UserGroupService::UserGroupsGetter.call(request: request)
                    present user_groups, with: Entities::UserGroupEntity

                end

                route_param :group_id, type: Integer do
                    desc 'join group'
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
end
