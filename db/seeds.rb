# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.map {|user| user.destroy}
Group.all.map {|group| group.destroy}
Music.all.map {|music| music.destroy}

Music.create({title: "가장 보통의 존재", artist: "언니네이발관", album: "가장 보통의 존재"})
Music.create({title: "아름다운 것", artist: "언니네이발관", album: "가장 보통의 존재"})
Music.create({title: "산들산들", artist: "언니네이발관", album: "가장 보통의 존재"})
Music.create({title: "인생은 금물", artist: "언니네이발관", album: "가장 보통의 존재"})
Music.create({title: "애도", artist: "언니네이발관", album: "홀로 있는 사람들"})
Music.create({title: "누구나 아는 비밀", artist: "언니네이발관", album: "홀로 있는 사람들"})
Music.create({title: "Missing you", artist: "Gdragon", album: "ONE OF A KIND"})
Music.create({title: "그XX", artist: "Gdragon", album: "ONE OF A KIND"})
Music.create({title: "Electra", artist: "검정치마", album: "Teen Troubles"})
Music.create({title: "매미들", artist: "검정치마", album: "Teen Troubles"})
Music.create({title: "따라갈래", artist: "검정치마", album: "Teen Troubles"})
Music.create({title: "plain jane", artist: "검정치마", album: "Girl Scout!"})
Music.create({title: "Big Love", artist: "검정치마", album: "Team Baby"})
Music.create({title: "피난", artist: "쏜애플", album: "이상기후"})
Music.create({title: "낯선 열대", artist: "쏜애플", album: "이상기후"})
