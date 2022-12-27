class GroupPlaylistMusic < ApplicationRecord
  belongs_to :group
  belongs_to :music
  belongs_to :user

  before_save :check_playlist_size

  private

  def check_playlist_size
    if group.group_playlist_musics.count >= 100
      group.user_playlist_musics.order(created_at: :asc).first.destroy
    end
  end
end
