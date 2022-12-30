module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :users do

                get :getinfo do

                    UserService::UserGetter.call(request: request)

                end

                get :usergroups do

                    UserService::UserGroupsGetter.call(request: request)

                end

                params do
                    requires :music_id
                end
                delete :cancellikesmusic do

                    UserService::UserLikesMusicCanceler.call(request: request)

                end

                params do
                    requires :music_id
                end
                post :likesmusic do

                    UserService::UserLikesMusicPoster.call(request: request)

                end

                desc 'list of musics that user likes'
                get :likedmusics do

                    UserService::UserLikesMusicsGetter.call(request: request)

                end

                desc 'get playlist of user'
                get :playlist do

                    UserService::UserMusicsGetter.call(request: request)

                end

                desc 'get group playlist which user joined'
                params do
                    requires :group_id
                end
                get :groupplaylist do

                    UserService::UserGroupMusicsGetter.call(request: request, group_id: params[:group_id])

                end

                desc 'add music to playlist for group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusicstogroup do

                    UserService::UserGroupMusicsAdder.call(request: request, group_id: params[:group_id], music_ids: params[:music_ids])

                end

                desc 'destroy music in playlist of group'
                params do
                    requires :group_id
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                delete :destroymusicofgroup do

                    UserService::UserGroupMusicsDestroyer.call(request: request, group_id: params[:group_id], music_ids: params[:music_ids])

                end

                desc 'join group'
                params do
                    requires :group_id
                end
                post :joingroup do

                    UserService::UserGroupJoiner.call(request: request, group_id: params[:group_id])

                end

                desc 'exit group'
                params do
                    requires :group_id
                end
                delete :exitgroup do

                    UserService::UserGroupExiter.call(request: request, group_id: params[:group_id])

                end


                desc 'add music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end
                post :addmusic do

                    UserService::UserMusicsAdder.call(request: request, music_ids: params[:music_ids])

                end

                desc 'delete music to playlist for user'
                params do
                    requires :music_ids, type: Array[Integer], desc: "Array of music ids to add to the playlist"
                end

                delete :destroymusic do

                    UserService::UserMusicsDestroyer.call(request: request, music_ids: params[:music_ids])

                end
            
                params do 
                    requires :user_name, type: String
                    requires :email, type: String 
                    requires :password, type: String
                end
                post "signup" do

                    UserService::UserSignup.call(user_name: params[:user_name], email: params[:email], password: params[:password])

                end

                params do
                    requires :email, type: String
                    requires :password, type: String
                end
                post "signin" do

                    UserService::UserSignin.call(email: params[:email], password: params[:password])
                    
                end
            end
        end
    end
end