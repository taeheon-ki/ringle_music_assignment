class ChangeUserMusicsNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_musics, :music_id, false
    change_column_null :user_musics, :user_id, false
  end
end
