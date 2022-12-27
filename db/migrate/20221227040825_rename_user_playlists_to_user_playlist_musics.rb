class RenameUserPlaylistsToUserPlaylistMusics < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_playlists, :user_playlist_musics
  end
end
