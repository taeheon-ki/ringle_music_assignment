
class ChangeDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :group_musics, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :group_musics, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
  end
end

