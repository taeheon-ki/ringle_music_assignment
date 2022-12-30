module UserService
    class UserGetter < ApplicationService
        def initialize(args)
            @user_id = args[:user_id]
        end

        def call
            user = User.find(@user_id).as_json(only: [:id, :user_name, :email])
        end
    end
end