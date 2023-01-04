module Entities
    class UserEntity < Grape::Entity
        expose :id, :user_name, :email
    end
end