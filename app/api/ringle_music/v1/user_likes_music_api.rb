module RingleMusic
    module V1
        class UserLikesMusicApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api
            helpers AuthHelper

            resource :user_likes_musics do

                route_param :music_id, type: Integer do

                    delete do
                        authenticate!
    
                        begin
                            UserLikesMusicService::UserLikesMusicCanceler.call(current_user, params[:music_id])
    
                        rescue ActiveRecord::RecordNotFound => e
                            return {success: false, message: "User doesn't like Found"}
                        rescue => e
                            return {success: false, message: e.message}
                        end
                        
    
                    end

                    post do
                        authenticate!
                        begin
                            UserLikesMusicService::UserLikesMusicPoster.call(current_user, params[:music_id])
    
                        rescue => e
                            return {success: false, message: e.message}
                        end
                        
    
                    end
                end

                

                desc 'list of musics that user likes'
                get do
                    authenticate!


                    musics = UserLikesMusicService::UserLikesMusicsGetter.call(current_user)
                    present musics, with: Entities::MusicEntity
                    

                end
            end
        end
    end
end
