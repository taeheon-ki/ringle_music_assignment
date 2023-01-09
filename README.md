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
  - 유저 10,000명
  - 그룹 100개
  - 음원 1500개 + fake 음원 100만개
  - 유저의 좋아요 10,000개

Modeling (Attributes)

<img src="modeling.png">

* 핵심 내용
  * Indexing
    * 음원 검색의 속도를 위해 Music 모델의 title, artist, album attributes에 index 설정을 해줌.
    * signup, signin을 할 때 User.findby email을 수행하기 때문에 여기에도 index 설정을 해줌.
  * 서비스화
    * 가독성 좋은 API를 위한 Modularization을 위해 서비스화
    * 현 개발팀이 사용하는 Convention 적용
    * 서비스화를 통해 API단에서 Authentication -> Services -> return(with exception handling)의 세 단계를 거치는 것으로 메커니즘 통일
  * Authentication
    * user가 login할 때 jwt_token 발급해서 전달해줌. 플레이리스트 추가, 좋아요 누르기 요청이 들어오면 jwt_token을 decode하여 user_id를 얻어 작업을 수행함. but bad guy가 똑같은 request를 보내면 어떻게 validation하지? => using nouns! 근데 지금 구현한 jwt_token validation에서 이걸 해주나?
    * jwt_token의 Validation (코드로 Go)
  * eager loading, pre loading, lazy loading
    * ToWrite
  * 검색 매커니즘
    * Soundex를 이용하여 발음이 비슷한 것들도 함께 찾아줌 => 1.2초
    * Soundex를 이용하지 않은 just full text search => 0.8초
  * 정렬 매커니즘 with limit
    * 좋아요 순, 최신순 => order.(attributes: :desc).limit(~)로 구현. all rows에 대해 ordering 진행 후 Limit으로 상위 몇 개만 가져올 수 있도록.
    * 정확도 순 => full text search로 찾은 rows들 중에 길이가 가장 비슷한 순서로 상위로 오도록 정렬
  * 개발팀에서 많이 사용하는 grape-entity 적용하여 response
  * 뮤직 여러개 insert mechanism (코드로 Go)
  * 뮤직 여러개 destroy mechanism (코드로 Go)
  * counter_cache 사용하여 user가 music에 좋아요를 누르거나 취소할 때마다 Music model의 해당하는 row의 attribute를 increment, decrement

* 구현한 API들
  * Postman으로 시현을 하는게 좋을까요 아니면 그냥 넘어갈까요?


* Todo
  - 서비스화 폴더 이름 다시 보기
  - Authentication reasoning
  - eager loading, preloading, lazy loading reasoning
  - get_services들에서 query searching하는 부분 Full text search로 바꾸기
  - seeds 다시 보기(user_group 등..)
  - 플레이리스트에 여러 음원 insert할 때 100개 넘어가면 옛날거부터 지우는 코드에 concurrency problem reasoning
  - using nouns! 근데 지금 구현한 jwt_token validation에서 이걸 해주나? 부분 reasoning
