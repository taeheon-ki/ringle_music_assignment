module GroupMusics
    class AddGroupMusicsService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @group_id = args[:group_id]
            @music_ids = args[:music_ids]
        end

        def call
            raise ActiveRecord::RecordNotFound , "UserGroup Not Exists" unless UserGroup.exists?(user_id: @current_user.id, group_id: @group_id)

            GroupMusic.insert_all!(
                @music_ids.map {|music_id| {
                user_id: @current_user.id, music_id: music_id, group_id: @group_id}})

            result = {}
            group = Group.find(@group_id)

            group_musics_count = group.group_musics.count

            num_musics_to_delete = group_musics_count - 100
            result[:success] = true
            if num_musics_to_delete > 0
                oldest_musics = GroupMusic.includes(:music).order(created_at: :asc).limit(num_musics_to_delete)
                result[:destroyed] = oldest_musics.map { |um| um.music.as_json(only: [:title, :artist, :album, :user_likes_musics_count])}

                oldest_musics.destroy_all

            end
            
            result
        end
    end
end
