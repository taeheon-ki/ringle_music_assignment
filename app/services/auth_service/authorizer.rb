module AuthService
    class Authorizer < ApplicationService
        def initialize(args)
            @request = args[:request]
        end

        def call
            unless @request.headers['Authorization']
                raise '응 Authorization 안됨~'
            end
    
            jwt_token = @request.headers['Authorization'].split(' ').last
    
            result = User.validate_jwt_token(jwt_token)
    
            unless result[:user_id]
                return {
                    success: false,
                    message: 'not a valid user'
                }
            end
            result[:user_id]
        end
    end
end