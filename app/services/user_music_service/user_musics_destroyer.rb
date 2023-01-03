module UserMusicService
    class UserMusicsDestroyer < ApplicationService
        def initialize(args)
            @request = args[:request]
            @music_ids = args[:music_ids]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            
            results = []
            user = User.find(@user_id)
            raise ActiveRecord::RecordNotFound unless user
            @music_ids.each do |music_id|
                result = { destroyed_music_id: music_id }
                
                musics = user.user_musics.where(music_id: music_id).order(created_at: :asc).limit(1)

                if musics.empty?
                    result[:message] = "Not Existing Music So Cannot Destroy"
                    result[:success] = false
                else
                    begin
                        musics.first.destroy!
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
