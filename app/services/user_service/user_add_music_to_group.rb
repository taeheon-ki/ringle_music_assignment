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
                GroupPlaylistMusic.create!({group_id: params[:group_id], music_id: music_id, user_id: user_id})
                rescue => e
                end
            end

            return {success: true}
        end
    end
end