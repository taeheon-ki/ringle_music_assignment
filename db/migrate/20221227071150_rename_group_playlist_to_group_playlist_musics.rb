class RenameGroupPlaylistToGroupPlaylistMusics < ActiveRecord::Migration[6.1]
  def change
    rename_table :group_playlists, :group_playlist_musics
  end
end
