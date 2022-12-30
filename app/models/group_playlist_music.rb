class GroupPlaylistMusic < ApplicationRecord
  belongs_to :group
  belongs_to :music
  belongs_to :user



  def as_music_json()
    {
      title: music.title,
      artist: music.artist,
      album: music.album,
      likes: music.user_likes_musics_count,
    }
  end

  private


end
