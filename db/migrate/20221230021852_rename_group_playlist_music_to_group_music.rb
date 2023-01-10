class RenameGroupPlaylistMusicToGroupMusic < ActiveRecord::Migration[6.1]
  def change
    rename_table :group_playlist_musics, :group_musics
  end
end
