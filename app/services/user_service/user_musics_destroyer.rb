module UserService
    class UserMusicsDestroyer < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
            @music_ids = args[:music_ids]
        end

        def call
            results = []
            @music_ids.each do |music_id|
                result = { destroyed_music_id: music_id }
                begin
                    user = User.find(@user_id)
                rescue
                    return {success: false, message: "User Not Found"}
                end
                musics = user.user_musics.where(music_id: music_id).order(created_at: :asc).limit(1)
                puts musics.empty?
                if musics.empty?
                    result[:message] = "Not Existing Music So Cannot Destroy"
                    result[:success] = false
                else
                    begin
                        musics.first.destroy
                        result[:success] = true
                    rescue => e
                        result[:success] = false
                        result[:message] = e.message
                    end
                    
                end

                results << result
            end

            results
        end
    end
end
