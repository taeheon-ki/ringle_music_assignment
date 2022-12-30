class GroupMusic < ApplicationRecord
  belongs_to :group
  belongs_to :music
  belongs_to :user

  def as_json_of_group_music()
    {
      id: music.id,
      title: music.title,
      artist: music.artist,
      album: music.album,
      likes: music.user_likes_musics_count,
      added_user_id: user.id,
    }
  end


end
