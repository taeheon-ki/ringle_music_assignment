class ChangeMusicsNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :musics, :title, false
    change_column_null :musics, :artist, false
    change_column_null :musics, :album, false
  end
end
