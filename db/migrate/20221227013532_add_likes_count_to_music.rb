class AddLikesCountToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :likes_count, :integer, default: 0
  end
end
