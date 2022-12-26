class GroupPlaylist < ApplicationRecord
  belongs_to :group
  belongs_to :music

  before_save :check_playlist_size

  private

  def check_playlist_size
    if user.user_playlists.count >= 100
      user.user_playlists.order(created_at: :asc).first.destroy
    end
  end
end
