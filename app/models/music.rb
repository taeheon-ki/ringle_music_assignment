class Music < ApplicationRecord
    has_many :likes, counter_cache: true
    has_many :likers, through: :likes, source: :user
    # has_and_belongs_to_many :user_playlists see again
    before_create :set_default_likes_count

    def set_default_likes_count
        self.likes_count ||=0
    end


end
