class UserLikesMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music, counter_cache: true
  validate :unique_membership
  
  def as_json_of_music()
    {
      id: music.id,
      title: music.title,
      artist: music.artist,
      album: music.album,
      likes: music.user_likes_musics_count,
    }
  end


  def unique_membership
    if UserLikesMusic.where(user: user, music: music).exists?
      errors.add(:base, "User is already liking this.")
    end
  end

  private


end
