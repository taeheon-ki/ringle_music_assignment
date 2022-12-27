class UserPlaylistMusic < ApplicationRecord
  belongs_to :user
  belongs_to :music

  before_save :check_playlist_size

  private

  def check_playlist_size
    if user.user_playlist_musics.count >= 100
      user.user_playlist_musics.order(created_at: :asc).first.destroy
    end
  end
end
