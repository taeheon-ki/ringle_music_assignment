module Entities
    class UserGroupEntity < Grape::Entity
        expose :user_id, :group_id
    end
end