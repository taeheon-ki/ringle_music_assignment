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

                    begin
                        UserLikesMusicService::UserLikesMusicCanceler.call(request: request, music_id: params[:music_id])

                    rescue ActiveRecord::RecordNotFound => e
                        return {success: false, message: "User doesn't like Found"}
                    rescue => e
                        return {success: false, message: e.message}
                    end
                    

                end

                params do
                    requires :music_id
                end
                post do
                    begin
                        UserLikesMusicService::UserLikesMusicPoster.call(request: request, music_id: params[:music_id])

                    rescue => e
                        return {success: false, message: e.message}
                    end
                    

                end

                desc 'list of musics that user likes'
                get do

                    musics = UserLikesMusicService::UserLikesMusicsGetter.call(request: request)
                    present musics, with: Entities::MusicEntity
                    
                end
            end
        end
    end
end
