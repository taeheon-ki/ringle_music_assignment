class RenameUserPlaylistMusicToUserMusic < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_playlist_musics, :user_musics
  end
end
