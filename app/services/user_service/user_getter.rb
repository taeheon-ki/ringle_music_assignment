module UserService
    class UserGetter < ApplicationService
        def initialize(current_user)
            @current_user = current_user
        end

        def call

            @current_user.as_json({
                only: [
                    :id,
                    :user_name,
                    :email
                ]
            })

        end
    end
end