class ChangeDefaultToGroupMusic < ActiveRecord::Migration[6.1]
  def change
    change_column_default :group_musics, :created_at, from: nil, to: Time.now
    change_column_default :group_musics, :updated_at, from: nil, to: Time.now
  end
end
