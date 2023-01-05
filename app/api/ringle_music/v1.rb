module RingleMusic
    module V1
        module AuthHelper
            def current_user
                return @current_user if @current_user
                if request.headers['Authorization']
                    jwt_token = request.headers['Authorization'].split(' ').last
                    @current_user = User.validate_jwt_token(jwt_token)
                    return @current_user
                end
                return @current_user = nil
            end

            def authenticate!
                error!('Unauthorized') unless current_user
            end

            def authenticate_with_password!(password)
                error!('Unauthorized') unless current_user

                is_valid = current_user.valid_password?(password)

                error!('Password not valid') unless is_valid
            end
        end
    end
end