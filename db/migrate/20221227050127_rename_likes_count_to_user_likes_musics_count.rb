class RenameLikesCountToUserLikesMusicsCount < ActiveRecord::Migration[6.1]
  def change
    rename_column :musics, :likes_count, :user_likes_musics_count
  end
end
