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
                    Group.create!(group_name: params[:group_name])
                    return {success: true}
                end

                desc 'List group'
                get do
                    groups = Group.all
                    present groups
                end
            end
        end
    end
end
