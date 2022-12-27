class RemoveLikesCountFromMusic < ActiveRecord::Migration[6.1]
  def change
    remove_column :musics, :likes_count
  end
end
