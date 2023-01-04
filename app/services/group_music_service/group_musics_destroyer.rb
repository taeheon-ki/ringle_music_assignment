module GroupMusicService
    class GroupMusicsDestroyer < ApplicationService
        def initialize(current_user, group_id, musics_id)
            @current_user = current_user
            @group_id = group_id
            @music_ids = musics_id
        end

        def call

            unless UserGroup.exists?(user_id: @current_user.id, group_id: @group_id)
                return {success: false, message: "user is not existing in group"}
            end
            results = []

            group = Group.find(@group_id)
            raise ActiveRecord::RecordNotFound unless group
            
            @music_ids.each do |music_id|
                result = {destroyed_music_id: music_id}
                
                musics = group.group_musics.where(music_id: music_id).order(created_at: :asc).limit(1)
                
                if musics.empty?
                    result[:message] = "Not Existing Music So Cannot Destroy"
                    result[:success] = false
                else

                    musics.first.destroy
                    result[:success] = true
                    
                end
                results << result
            end
            results
        end
    end
end

