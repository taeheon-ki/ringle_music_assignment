# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
## Make Musics
require 'csv'
require 'faker'


# User.all.map {|user| user.destroy}
# Group.all.map {|group| group.destroy}
# Music.all.map {|music| music.destroy}



music_count = 1500
sample_music_file =  Rails.root.join("config", "musics", "music.csv")
music_csvs = CSV.parse(File.read(sample_music_file), :headers=>true)
music_csv_sampled = music_csvs[0..(music_count-1)]
music_csv_sampled.map { |music_csv|
    music_csv = music_csv.to_hash
    Music.create(title: music_csv["title"], artist: music_csv["artist_name"], album: music_csv["album_name"])
}

user_count = 10_000
group_count = 100

user_likes_musics_count = 10_000



user_count.times do
  # generate a fake user
  username = Faker::Internet.user_name
  email = Faker::Internet.email
  password = SecureRandom.hex(10)

  # check if the user already exists in the array
  while User.exists?(user_name: username)
    # if it does, generate a new user_name
    username = Faker::Internet.user_name
  end
  email = Faker::Internet.email
  while User.exists?(email: email)
      # if it does, generate a new user_name
      email = Faker::Internet.email
  end

  # add the user record to the array
  User.create(user_name: username, email: email, password: password)
end

# insert the array of user records into the database
musics = []
music_batch_size = 1_000
num_batches = 1_000
1.upto(num_batches) do |batch|
  1.upto(music_batch_size) do |i|
  # generate a fake music record
    title = "Music #{i}"
    artist = Faker::Artist.name
    album = Faker::Music.album

    # add the music record to the array
    musics << {title: title, artist: artist, album: album}
  end
  Music.insert_all(musics)
  musics.clear
end
# insert the array of music records into the database

groups = []
1.upto(group_count) do |i|
  # generate a fake music record
  group_name = "Group #{i}"
  user_id = User.all.sample.id

  # add the music record to the array
  groups << {group_name: group_name, user_id: user_id}
end
Group.insert_all(groups) if groups.count > 0

user_likes_musics_count = 1000

user_likes_musics_count.times do
  # generate a fake user
  user_id = User.all.sample.id
  music_id = 501023
  while UserLikesMusic.where(user_id: user_id, music_id: music_id).exists?
    # if it does, generate a new user_name
    user_id = User.all.sample.id
  end
  
  # add the user record to the array
  UserLikesMusic.create(user_id: user_id, music_id: music_id)
end