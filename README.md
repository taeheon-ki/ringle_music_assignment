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
  * 회원가입 : post
    * route : api/v1/signup
    * parameter : user_name, email, password
  * 로그인 : post
    * route : api/v1/signin
    * parameter : emali, password
    * return : jwt_token. Below API들은 Authorization header에 bearer + jwt_token 필요
  * 유저 정보 조회하기 : get
    * route : api/v1/users/getinfo
    * paramter : x
  * 유저가 음악에 좋아요 누르기 : post
    * route : api/v1/users/likesmusic
    * parameter : music_id
  * 유저가 음악에 누른 좋아요 취소하기 : delete
    * route : api/v1/users/cancellikesmusic
    * paramter : music_id
  * 유저가 좋아하는 음악 리스트 보기: get
    * route : api/v1/users/likedmusics
    * parameter : x
  * 유저의 플레이리스트 보기: get
    * route : api/v1/uesrs/playlist
    * parameter : x
  * 유저가 속한 그룹의 플레이리스트 보기: get
    * route : api/users/groupplaylist
    * parameter : group_id
  * 유저의 플레이리스트에 음원 추가 : post
    * route : api/v1/users/addmusic
    * parameter : body에 json형식의 music_ids array
  * 유저의 플레이리스트에서 음원 제거 : delete
    * route : api/v1/users/destroymusic
    * parameter : body에 json형식의 music_ids array
  * 유저가 그룹에 조인하기 : post
    * route : api/v1/users/joingroup
    * parameter : group_id
  * 유저가 그룹에서 나가기 : delete
    * route : api/v1/users/exitgroup
    * parameter : group_id
  * 유저가 그룹에 음원 추가하기 : post
    * route : api/v1/users/addmusicstogroup
    * parameter : group_id, body에 json형식의 music_ids array
  * 유저가 그룹에서 음원 제거 : delete
    * route : api/v1/users/destroymusicsofgroup
    * parameter : group_id, body에 json형식의 music_ids array
  * 유저가 속한 그룹 리스트 보기: get
    * route : api/v1/users/usergroups
    * parameter : x
* Music API
  * 음악 검색, 정렬한 리스트 보기: get
    * route : api/v1/musics
    * parameter : (optional)sort : (accuracy, likes, created_at 중 1), (optional)query
* Group API
  * 그룹 추가하기 : post
    * route : api/v1/groups/create
    * parameter : group_name
  * 전체 그룹 리스트 보기 : get
    * route : api/v1/groups
    * parameter : x

* Todo
  * DB 성능 이슈 : index 고려, each문마다 날리게 되는 SQL query refactoring
  * Concurrency 이슈 : multi-thread가 interleaving하다가 발생할 수 있는 문제 고려, transaction, commit point 적용?
  * error-prone한 코드 찾기
  * authorization 거쳐야 하는 private하게 만들어 놓은 api들 optional parameter 줘서 public하게?
  * renaming?
  * schema에서 default, null:false, foreign key constraint 부분 다시 고려
  * api 추가?
  * 