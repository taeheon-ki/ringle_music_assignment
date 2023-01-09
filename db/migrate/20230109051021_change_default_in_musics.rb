class ChangeDefaultInMusics < ActiveRecord::Migration[6.1]
  def change
    change_column_default :musics, :created_at, from: nil, to: Time.now
    change_column_default :musics, :updated_at, from: nil, to: Time.now
  end
end
