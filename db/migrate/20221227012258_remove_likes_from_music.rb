class RemoveLikesFromMusic < ActiveRecord::Migration[6.1]
  def change
    remove_column :musics, :likes
  end
end
