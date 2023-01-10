class AddIndexToMusic < ActiveRecord::Migration[6.1]
  def change
    add_index :musics, :title
    add_index :musics, :artist
    add_index :musics, :album
  end
end
