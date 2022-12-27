class Group < ApplicationRecord
    validates :group_name, uniqueness: { message: "Groupname must be unique"}
    has_many :group_playlist_musics
end
