module UserService
    class UserGroupMusicsDestroyer < ApplicationService
        def initialize(args)
            @request = args[:request]
            @group_id = args[:group_id]
            @music_ids = args[:music_ids]
        end

        def call
            do_authorization
            group_exist_validation
            results = []
            @music_ids.each do |music_id|
                result = {destroyed_music_id: music_id}

                group = Group.find(@group_id)
                musics = group.group_musics.where(music_id: music_id).order(created_at: :asc).limit(1)
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

        private
        def group_exist_validation
            unless UserGroup.exists?(user_id: @user_id, group_id: @group_id)
                return {success: false, message: "user is not existing in group"}
            end
        end
        
        def do_authorization
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
        end
    end
end

