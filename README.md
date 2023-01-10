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
  - 소요시간 1시간 3분

Modeling (Attributes)

<img src="modeling.png">

* 핵심 내용
  * 서비스화
    * 가독성 좋은 API를 위한 Modularization
    * 서비스화를 통해 API단에서 Authentication -> Services(processing) -> return(with exception handling)의 세 단계를 거치는 것으로 메커니즘 통일
  * Authentication
    * user가 login할 때 jwt_token 발급해서 전달해줌. 플레이리스트 추가, 좋아요 누르기 요청이 들어오면 jwt_token을 decode하여 user_id를 얻어 작업을 수행함.
    * 의문점 : but bad guy가 replay attack을 걸어왔을 때 jwt_token으로 authentication하면 통과해서 malicious request가 작동할 수 있지 않을까? => 작동할 수 있다고 생각!
      * [EX] 어떤 유저가 특정 Request 보냄 => 중간 도청자(bad guy)가 똑같은 Request를 그대로 Replay해서 서버에 보냄 => 서버는 Request를 jwt_token으로 authentication => 유저가 의도하지 않은 api 호출 가능(결제 request가 호출되면 큰 일)
      * 해결책 : Stateful verification! nonce라는 무작위 암호 이용, timestamp 이용, 등등...
      * 하지만 이러한 stateful verification은 Dos공격에 취약! 상대가 Valid한 request를 계속 보내면 우리는 stateful verification을 위해 resource 사용이 필요!
      * 방지법 1. 공격을 인지하면 공격자의 ip를 차단 : 공격자가 vpn등으로 ip를 계속 변조하여 공격할 수 있음..
      * 방지법 2. single ip source에서 오는 Request에 limit! : 정상적인 user들의 request에는 영향 끼치지 않을 정도로 가능한가?( chatgpt에서 과도한 request를 막기 위해 single ip source에서 오는 request에 limit을 건 것 같은데 사용자 입장에선 조금 불편... )
      * 방지법 3. 비정상적으로 많아지는 request를 처리하는 시간을 exponential하게 증가시키기 : 감당할 수 있을 정도로는 참다가 선을 넘으면 넘을수록 큰 제재를 가하기
  * 검색 매커니즘
    * Soundex를 이용하여 발음이 비슷한 것들도 함께 찾아주는 기능 추가 => 100만건에 대해 ordering => 1.2초
      * [EX] bandd를 검색해도 band를 반환
  * 정렬 매커니즘 with limit
    * 좋아요 순, 최신순 => 검색을 통해 musics를 찾은 후 musics.order.(attributes: :desc).limit(~)로 구현. all rows에 대해 ordering 진행 후 Limit으로 상위 몇 개만 가져올 수 있도록.
    * 정확도 순 => 검색을 통해 musics를 찾은 후 중에 길이가 가장 비슷한 순서로 상위로 오도록 정렬
  * Indexing
    * 음원 검색의 속도를 위해 Music 모델의 title, artist, album attributes에 index 설정을 해줌.
    * signup, signin을 할 때 User.findby email을 수행하기 때문에 여기에도 index 설정을 해줌.
  * Convention 적용 연습
    * grape-entity 적용하여 response
    * service화 할 때 naming convention 연습
    * service단에서 raise exception -> api단에서 begin rescue
    * git flow - 이슈 작성하고 dev branch 파고 issue 번호에 해당하는 feature/issue-xxx branch 파서 작업한 후 dev branch로 pull request
  * 뮤직 여러개 insert mechanism => 유저의 음원이 100개 넘지 않도록 하는 메커니즘 (코드로 Go)
  * counter_cache 사용하여 user가 music에 좋아요를 누르거나 취소할 때마다 Music model의 해당하는 row의 attribute를 increment, decrement, 주의할 점은 trigger가 안불리는 delete같은 것을 쓰면 업데이트 안 됨!

* 구현한 API들
  * Postman과 mysql Workbench로 시현을 하는게 좋을까요 아니면 그냥 넘어갈까요?
