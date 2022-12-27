class User < ApplicationRecord
    validates :user_name, uniqueness: { message: "Groupname must be unique"}

    has_many :user_playlist_musics
    has_many :user_likes_musics
    has_many :group_playlist_musics
    has_many :group_users
    
    has_many :groups, through: :group_users
end
