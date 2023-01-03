module UserMusicService
    class UserMusicsAdder < ApplicationService
        def initialize(args)
            @request = args[:request]
            @music_ids = args[:music_ids]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result

            UserMusic.insert_all(
                @music_ids.map {|music_id| {
                user_id: @user_id, music_id: music_id}})

            result = {}
            user = User.find(@user_id)
            
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