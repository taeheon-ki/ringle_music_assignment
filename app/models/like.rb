class Like < ApplicationRecord
  belongs_to :user
  belongs_to :music, counter_cache: :likes_count
  validate :unique_membership
  


  def unique_membership
    if Like.where(user: user, music: music).exists?
      errors.add(:base, "User is already liking this.")
    end
  end

  private


end
