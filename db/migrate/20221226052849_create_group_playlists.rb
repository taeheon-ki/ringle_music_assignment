class CreateGroupPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :group_playlists do |t|
      t.references :group, foreign_key: true
      t.references :music, foreign_key: true

      t.timestamps
    end
  end
end
