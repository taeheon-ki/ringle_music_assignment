class UserPlaylistMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music

  before_save :check_playlist_size

  def as_music_json()
    {
      title: music.title,
      artist: music.artist,
      album: music.album,
      likes: music.user_likes_musics_count,
    }
  end

  private

  def check_playlist_size
    if user.user_playlist_musics.count >= 100
      user.user_playlist_musics.order(created_at: :asc).first.destroy
    end
  end
end
