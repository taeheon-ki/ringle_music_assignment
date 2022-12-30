module UserService
    class UserMusicsAdder < ApplicationService
        def initialize(args)
            @request = args[:request]
            @music_ids = args[:music_ids]
        end

        def call
            do_authorization
            results = []
            @music_ids.each do |music_id|
                result = { music_id_added: music_id}
                begin
                    UserMusic.create!({user_id: @user_id, music_id: music_id})
                    user = User.find(@user_id)
                    user_musics = user.user_musics
                    if user_musics.count >= 100
                        destroy_music = user_musics.order(created_at: :asc).first
                        result[:destroyed] = destroy_music.as_json_of_music
                        destroy_music.destroy
                    end
                    result[:success] = true
                rescue => e
                    result[:success] = false
                    result[:message] = e.message
                end
                results << result
            end

            return results
        end
        
        private
        def do_authorization
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
        end
    end
end