class User < ApplicationRecord
    validates :user_name, uniqueness: { message: "Groupname must be unique"}
    has_and_belongs_to_many :user_playlists
    has_many :likes
    has_many :liked_musics, through: :likes, source: :music
end
