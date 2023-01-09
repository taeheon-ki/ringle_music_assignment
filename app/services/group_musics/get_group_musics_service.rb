module GroupMusics
    class GetGroupMusicsService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @group_id = args[:group_id]
            @query = args[:query] if args.key?(:query)
        end

        def call
            
            raise ActiveRecord::RecordNotFound , "UserGroup Not Exists" unless UserGroup.exists?(user_id: @current_user.id, group_id: @group_id)

            
            group_musics = Music.joins(:group_musics).select('musics.id, musics.title, musics.artist, musics.album, group_musics.user_id').where('group_musics.group_id = ?', @group_id)
            filtered_musics = group_musics.where(
                "SOUNDEX(title) = SOUNDEX(:query) OR title LIKE :like_query OR
                SOUNDEX(artist) = SOUNDEX(:query) OR artist LIKE :like_query OR
                SOUNDEX(album) = SOUNDEX(:query) OR album LIKE :like_query",
                query: @query, like_query: "%#{@query}%")
        end
    end
end