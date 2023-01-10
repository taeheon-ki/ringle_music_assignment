class RenameLikesToUserLikesMusics < ActiveRecord::Migration[6.1]
  def change
    rename_table :likes, :user_likes_musics
  end
end
