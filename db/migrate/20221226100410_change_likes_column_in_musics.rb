class ChangeLikesColumnInMusics < ActiveRecord::Migration[6.1]
  def change
    change_column_default :musics, :likes, default: 0
  end
end
