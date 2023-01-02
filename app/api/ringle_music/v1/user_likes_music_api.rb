module RingleMusic
    module V1
        class UserLikesMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :user_likes_musics do

                params do
                    requires :music_id
                end
                delete do

                    UserLikesMusicService::UserLikesMusicCanceler.call(request: request, music_id: params[:music_id])

                end

                params do
                    requires :music_id
                end
                post do

                    UserLikesMusicService::UserLikesMusicPoster.call(request: request, music_id: params[:music_id])

                end

                desc 'list of musics that user likes'
                get do

                    UserLikesMusicService::UserLikesMusicsGetter.call(request: request)

                end
            end
        end
    end
end
