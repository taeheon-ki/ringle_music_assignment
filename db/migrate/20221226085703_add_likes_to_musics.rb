class AddLikesToMusics < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :likes, :integer
  end
end
