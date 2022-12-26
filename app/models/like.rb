class Like < ApplicationRecord
  belongs_to :user
  belongs_to :music
  validate :unique_membership

  def unique_membership
    if Like.where(user: user, music: music).exists?
      errors.add(:base, "User is already liking this.")
    end
  end
end
