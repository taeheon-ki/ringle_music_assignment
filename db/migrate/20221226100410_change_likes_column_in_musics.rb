class ChangeLikesColumnInMusics < ActiveRecord::Migration[6.1]
  def change
    change_column_default :musics, :integer, :likes, default: 0
    Music.update_all(likes: 0)
  end
end
