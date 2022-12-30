module UserService
    class UserGroupMusicsAdder < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @group_id = args[:group_id]
            @music_ids = args[:music_ids]
        end

        def call
            results = []
            @music_ids.each do |music_id|
                result = {music_id: music_id}
                begin
                    GroupMusic.create!({group_id: @group_id, music_id: music_id, user_id: @user_id})
                    group = Group.find(@group_id)
                    group_musics = group.group_musics
                    if group_musics.count >= 100
                        destroy_music = group_musics.order(created_at: :asc).first
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
