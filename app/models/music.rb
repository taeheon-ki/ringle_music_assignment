class Music < ApplicationRecord
    validates_uniqueness_of :title, :artist, :album, scope: [:title, :artist, :album], message: "Music must be unique"

    has_many :user_likes_musics, counter_cache: :user_likes_musics_count
    has_many :user_musics
    has_many :group_musics
    before_create :set_default_likes_count

    def set_default_likes_count
        self.user_likes_musics_count ||=0
    end


end
