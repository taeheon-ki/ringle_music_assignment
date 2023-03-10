module GroupMusics
    class DestroyGroupMusicsService < ApplicationService
        def initialize(current_user, **args)
            @current_user = current_user
            @group_id = args[:group_id]
            @music_ids = args[:musics_id]
        end

        def call

            raise ActiveRecord::RecordNotFound , "UserGroup Not Exists" unless UserGroup.exists?(user_id: @current_user.id, group_id: @group_id)
            results = []

            group = Group.includes(:group_musics).find(@group_id)

            
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

