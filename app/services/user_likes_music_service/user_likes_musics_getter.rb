module UserLikesMusicService
    class UserLikesMusicsGetter < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            auth_result = AuthService::Authorizer.call(request: @request)
            return auth_result if auth_result.is_a?(Hash)
            @user_id = auth_result
            
            user_liked_list = UserLikesMusic.where(user_id: @user_id)
            user_liked_list.map(&:as_json_of_music)
        end
    end
end