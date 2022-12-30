# README

RingleMusic - taeheon.ki

Version
* ruby: 2.6.3p62
* rails: 6.1.7
* mysql: 8.0.31

Install
* bundle
* rake db:create
* rake db:migrate
* rake db:seed
  - User, Music, Group 초기화
  - 음원 15개 추가

Modeling (Attributes)
* User (user_id, user_name, email, password)
* Group (group_id, group_name)
* Music (music_id, title, artist, album, user_likes_musics_count)

Relation Tables
* UserGroup (user_id, group_id) : User와 Group의 Relation

* UserMusic (user_id, music_id) : User's Playlist
* GroupMusic (group_id, music_id, user_id) : Group's Playlist. user_id로 이 playlist에 음원 추가한 user 확인가능

* UserLikesMusic (user_id, music_id) : User가 좋아한 Music

APIs
* app/api/ringle_music/v1에 구현
* app/services 폴더에 modularization
* User API
  * 회원가입
    * route : api/v1/signup
    * parameter : user_name, email, password
    * return : Success여부, Error message
  * 로그인
    * route : api/v1/signin
    * parameter : emali, password
    * return : success여부, error message, jwt_token
  * Below API들은 Authorization header에 bearer + jwt_token 필요
  * 유저 정보 조회
    * route : api/v1/users/getinfo
    * return : id, username, email 정보
  * 유저가 음악에 좋아요 누르기
    * route : api/v1/users/likesmusic
    * parameter : music_id
    * return : Success여부, Error message
  * 유저가 음악에 누른 좋아요 취소하기
    * route : api/v1/users/cancellikesmusic
    * paramter : music_id
    * return : Success여부, Error message
  * 유저가 좋아하는 음악 리스트
    * route : api/v1/users/likesmusics