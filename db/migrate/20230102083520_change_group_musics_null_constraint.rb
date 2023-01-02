class ChangeGroupMusicsNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :group_musics, :group_id, false
    change_column_null :group_musics, :music_id, false
    change_column_null :group_musics, :user_id, false
  end
end
