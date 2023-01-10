class ChangeDefaultToUserMusicsAndUserLikesMusicsAndUserGroups < ActiveRecord::Migration[6.1]
  def change
    change_column :user_musics, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :user_musics, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :user_likes_musics, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :user_likes_musics, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :user_groups, :created_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
    change_column :user_groups, :updated_at, :datetime, default: -> { "CURRENT_TIMESTAMP" }
  end
end
