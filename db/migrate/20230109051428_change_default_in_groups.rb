class ChangeDefaultInGroups < ActiveRecord::Migration[6.1]
  def change
    change_column :group_musics, :created_at, :datetime, :default => DateTime.now
    change_column :group_musics, :updated_at, :datetime, :default => DateTime.now
  end
end
