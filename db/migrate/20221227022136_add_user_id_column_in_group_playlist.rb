class AddUserIdColumnInGroupPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_column :group_playlists, :user_id, :bigint
  end
end
