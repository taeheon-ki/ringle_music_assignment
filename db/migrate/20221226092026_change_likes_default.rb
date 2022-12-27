class ChangeLikesDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :musics, :likes, 0
  end
end
