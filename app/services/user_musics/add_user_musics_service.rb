module UserMusics
    class AddUserMusicsService < ApplicationService
        class TransactionError < StandardError; end
        def initialize(current_user, **args)
            @current_user = current_user
            @music_ids = args[:music_ids]
        end

        def call
            result = {}
            result[:success] = true
          
            begin # insert, destroy 모두 되거나 안되거나
                ActiveRecord::Base.transaction do
                    UserMusic.insert_all!(
                    @music_ids.map {|music_id| {
                        user_id: @current_user.id, music_id: music_id}}
                    )
            
                    user = @current_user
                    user_musics_count = user.user_musics.count
            
                    num_musics_to_delete = user_musics_count - 100 # interleaving problem can be happened
            
                    if num_musics_to_delete > 0
                        if num_musics_to_delete > @music_ids.count
                            num_musics_to_delete = @music_ids.count
                        end
                        oldest_musics = UserMusic.includes(:music).order(created_at: :asc).limit(num_musics_to_delete)
                        result[:destroyed] = oldest_musics.map { |um| um.music.as_json(only: [:title, :artist, :album, :user_likes_musics_count])}
                
                        num_destroy = oldest_musics.destroy_all
                    end
                end
            rescue
                raise TransactionError, "Transaction Error!"
            end
        
            result
        end
    end
end