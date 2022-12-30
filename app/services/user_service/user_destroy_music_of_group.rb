module UserService
    class UserAddMusicToGroup < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @group_id = args[:group_id]
            @music_ids = args[:music_ids]
        end

        def call
            ToDo!()
            
            music_ids.each do |music_id|
                begin
                    group_playlist_music = GroupPlaylistMusic.where(group_id: group_id, music_id: music_id)
                    
                    if group_playlist_music.empty?
                        return {
                            success: false, message: "not existing music.."
                        }
                    end
            
                    group_playlist_music.first.destroy
                rescue => e
                end
            end
            
            return {success: true}
        end
    end
end