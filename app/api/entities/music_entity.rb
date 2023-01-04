module Entities
    class MusicEntity < Grape::Entity
        expose :id, :title, :artist, :album, :user_likes_musics_count
    end
end