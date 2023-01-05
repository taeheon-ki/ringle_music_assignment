module UserMusics
    class AddUserMusicsService < ApplicationService
        def initialize(current_user, music_ids)
            @current_user = current_user
            @music_ids = music_ids
        end

        def call


            UserMusic.insert_all(
                @music_ids.map {|music_id| {
                user_id: @current_user.id, music_id: music_id}})

            result = {}
            user = @current_user
            
            user_musics_count = user.user_musics.count

            num_musics_to_delete = user_musics_count - 100
            result[:success] = true
            if num_musics_to_delete > 0
                oldest_musics = UserMusic.includes(:music).order(created_at: :asc).limit(num_musics_to_delete)
                result[:destroyed] = oldest_musics.map { |um| um.music.as_json(only: [:title, :artist, :album, :user_likes_musics_count])}

                oldest_musics.destroy_all!

            end
            
            result
        end
    end
end