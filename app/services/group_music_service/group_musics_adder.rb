module GroupMusicService
    class GroupMusicsAdder < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
            @music_ids = args[:music_ids]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result

            unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)
                return {success: false, message: "user is not existing in group"}
            end
            results = []
            @music_ids.each do |music_id|
                result = {music_id: music_id}
                begin
                    GroupMusic.create!({group_id: @group_id, music_id: music_id, user_id: @user_id})
                    
                    group = Group.find(@group_id)
                    group_musics = group.group_musics
                    if group_musics.count >= 100
                        destroy_music = group_musics.order(created_at: :asc).first
                        result[:destroyed] = destroy_music.music.as_json(only: [:title, :artist, :album, :user_likes_musics_count])
                        destroy_music.destroy
                    end
                    result[:success] = true
                rescue => e
                    result[:success] = false
                    result[:message] = "Music is not exist"
                end
                results << result
            end
            return results
        end
    end
end