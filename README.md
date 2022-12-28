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
* rake db:seed(not yet)

Requirements
* 음원

  - [x] 음원 검색 API
    * 정확도순, 인기순, 최신순
    * http://localhost:3000/api/v1/musics/ : 모든 음원 목록
    * http://localhost:3000/api/v1/musics?q=xxx&sort=accuracy : xxx를 검색하여 accuracy로 정렬. sort에는 accuracy, likes, created_at이 들어갈 수 있음.


* 플레이리스트

  - [ ] 플레이리스트 조회 API
    * 특정 유저, 그룹에 속한 플레이리스트 조회
    * 유저, 그룹 소유자만 가능
    * 어떤 유저가 플레이리스트에 음원 추가했는지 확인 가능
  - [ ] 플레이리스트에 음원 추가, 삭제 API
    * 최대 100개까지 음원 유지
    * 플레이리스트 소유하는 그룹, 유저 소유자만 가능
    * n개를 한번에 추가, 삭제 가능

* 유저

  - [ ] 유저가 좋아요 누른 모든 음원 확인 API
    * 유저 자신것만 확인가능
  - [ ] 로그인 회원가입 API
  - [ ] 그룹에 조인, 나가기 API

* 그룹

  - [ ] 그룹 목록 조회 API
    * 그룹에 속한 유저만 조회가능
  - [ ] 그룹 만들기 API

API

- http://localhost:3000/api/v1/musics/search?sort=likes : 좋아요 순 정렬
- http://localhost:3000/api/v1/musics/search?sort=created_date : 최신 순 정렬
- 