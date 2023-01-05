module UserMusics
    class DestroyUserMusicsService < ApplicationService
        def initialize(current_user, music_ids)
            @current_user = current_user
            @music_ids = music_ids
        end

        def call

            
            results = []
            user = @current_user

            @music_ids.each do |music_id|
                result = { destroyed_music_id: music_id }
                
                musics = user.user_musics.where(music_id: music_id).order(created_at: :asc).limit(1)

                if musics.empty?
                    result[:message] = "Not Existing Music So Cannot Destroy"
                    result[:success] = false
                else

                    musics.first.destroy!
                    result[:success] = true

                end
                results << result
            end
            results
        end
    end
end
