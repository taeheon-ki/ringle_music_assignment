module Entities
    class GroupMusicEntity < Grape::Entity
        expose :group_id, :title, :artist, :album, :user_id
    end
end