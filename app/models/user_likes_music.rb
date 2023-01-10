class UserLikesMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music, counter_cache: true
  validate :unique_membership
  


  def unique_membership
    if UserLikesMusic.where(user_id: user.id, music_id: music.id).exists?
      errors.add(:base, "User is already liking this.")
    end
  end

  private


end
