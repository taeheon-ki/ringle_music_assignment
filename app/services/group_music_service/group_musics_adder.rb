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
            begin
                GroupMusic.insert_all(@music_ids.map {|music_id| {
                    user_id: @user_id, music_id: music_id, group_id: @group_id,
                    created_at: Time.current, updated_at: Time.current}})
            rescue => e
                return {success: false, e_message: e.message ,message: "Insertion Failed! All Insertion Rollbacked"}
            end
            result = {}
            group = Group.find(@user_id)
            group_musics_count = group.group_musics.count

            num_musics_to_delete = group_musics_count = group_musics_count - 100
            result[:success] = true
            if num_musics_to_delete > 0
                oldest_musics = GroupMusic.includes(:music).order(created_at: :asc).limit(num_musics_to_delete)
                result[:destroyed] = oldest_musics.map { |um| um.music.as_json(only: [:title, :artist, :album, :user_likes_musics_count])}
                begin
                    oldest_musics.destroy_all
                rescue
                    return {success: false, message: "Destroy_all Failed!"}
                end
            end
            
            result
        end
    end
end
