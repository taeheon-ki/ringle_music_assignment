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
                post :create do
                    begin
                        Group.create!(group_name: params[:group_name])
                        return {success: true}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                end

                desc 'List group'
                get do
                    groups = Group.all
                    groups = groups.as_json(only:[:id, :group_name])
                end
            end
        end
    end
end
