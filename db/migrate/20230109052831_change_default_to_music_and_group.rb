class ChangeDefaultToMusicAndGroup < ActiveRecord::Migration[6.1]
  def change
    change_column :musics, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :musics, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :groups, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :groups, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
  end
end
