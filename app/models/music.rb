class Music < ApplicationRecord
    validates_uniqueness_of :title, :artist, :album, scope: [:title, :artist, :album], message: "Music must be unique"

    has_many :user_likes_musics, counter_cache: :user_likes_musics_count
    has_many :user_musics
    has_many :group_musics


end
