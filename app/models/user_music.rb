class UserMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music


  def as_json_of_music()
    {
      id: music.id,
      title: music.title,
      artist: music.artist,
      album: music.album,
      likes: music.user_likes_musics_count,
    }
  end


end
