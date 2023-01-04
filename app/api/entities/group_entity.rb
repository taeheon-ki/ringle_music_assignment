module Entities
    class GroupEntity < Grape::Entity
        expose :id, :group_name
    end
end