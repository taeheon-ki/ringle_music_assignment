class CreateUserPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :user_playlists do |t|
      t.references :user, foreign_key: true
      t.references :music, foreign_key: true

      t.timestamps
    end
  end
end
