module UserService
    class UserPlaylistMusicAdder < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @music_ids = args[:music_ids]
        end

        def call
            results = []
            @music_ids.each do |music_id|
                result = { music_id: music_id}
                begin
                    UserPlaylistMusic.create!({user_id: @user_id, music_id: music_id})
                    user = User.find(@user_id)
                    user_playlist_musics = user.user_playlist_musics
                    if user_playlist_musics.count >= 100
                        destroy_music = user_playlist_musics.order(created_at: :asc).first
                        result[:destroyed] = destroy_music.as_music_json
                        destroy_music.destroy
                    end
                    result[:success] = true
                rescue => e
                    result[:success] = false
                    result[:message] = e.message
                end

                

                results << result
            end

            return results
        end
    end
end