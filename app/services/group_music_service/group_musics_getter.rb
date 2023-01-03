module GroupMusicService
    class GroupMusicsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result

            
            raise ActiveRecord::RecordNotFound , "UserGroup Not Exists" unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)


            puts @group_id
            
            group_musics = Music.joins(:group_musics).select('musics.id, musics.title, musics.artist, musics.album, group_musics.user_id').where('group_musics.group_id = ?', @group_id)

        end
    end
end