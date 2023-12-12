# JSP_Community-Site
JSP로 제작한 커뮤니티 사이트 개인 프로젝트입니다.

사이트의 전체적인 레이아웃과 로그인, 회원가입 페이지는 부트스트랩을 이용하였습니다.




# 사용한 기술스택

* JAVA11

* JSP

* HTML5

* CSS

* JavaScript

* Mysql

# 구현기능

* 계정관련
  - 로그인, 로그아웃
  -  회원가입, 회원정보수정, 회원탈퇴
  -  비밀번호 찾기


* 게시판
  - 모든 게시글과 댓글은 로그인 시에만 작성 및 수정 가능
  - 게시글 작성, 수정, 삭제
  - 게시글 작성시 이미지 첨부 가능
  - 댓글 작성, 수정, 삭제
  - 게시글 조회수 집계

# DB구성

* 유저와 게시판 데이터를 담는 두개의 테이블로 구성



*__유저 테이블(user_data)__
![db_user](https://github.com/nacknock/festival_project/assets/151377332/817ac452-59db-45a3-ac71-6d9245f39e31)

*__게시글 테이블(board_data)__
 - date : insert시 getDate()를 통해 현재 시간 입력
 - Available : 회원탈퇴시 DB에는 데이터를 남겨두고 유저를 구분하기 위해(평상시 1, 탈퇴시 0)
 - board : 게시글이 소속될 게시판
 - b_num : 게시판 내에서의 게시글 번호
 - c_num : 게시글 내에서의 댓글 순서(0일시 댓글 없음)
 - filename, filerealname : 이미지를 업로드했을때 유저가 직접 지정한 파일명, 실제 저장되는 파일명
 - img_bool : 게시글에 이미지가 포함되어있는지 여부 (0일시 X, 1일시 O)
![db_user-table](https://github.com/nacknock/festival_project/assets/151377332/0147d557-ae00-4802-badf-cd67f28d9e64)
 # 이미지

 프로젝트 실제 화면

 * __메인 페이지__
   - 페이지 중앙 목록에 각 게시판 최신글들을 배치, 클릭시 해당 게시글로 이동 가능
   - 게시글 제목, 작성자, 게시글 내용 중 하나를 택해 검색 가능

 ![제목 없음](https://github.com/nacknock/festival_project/assets/151377332/2b6cd410-34c2-4ef4-a920-0eeb980f1fac)



* __로그인, 회원가입__
 - 로그인, 회원가입 실패 시 alert창 작동
 - 비밀번호 찾기 구현
 - 회원가입시 정규표현식 사용( id,pw,email 적용)
 - 회원가입 버튼 눌렀을시 아이디 중복 여부 및 패스워드 확인 일치 체크

<img src = https://github.com/nacknock/festival_project/assets/151377332/cce7693c-2bac-46d3-b9c9-ce4d6468646b width="500" height="450" /><img src = https://github.com/nacknock/festival_project/assets/151377332/19675ae5-179d-41a7-8336-bca1be00ed59 width="500" height="450" />

* __게시판__
  - 글번호, 제목, 작성자, 작성일, 조회수 표시
  - 분야에 따라 4가지 게시판 제작(강아지,고양이,그 외, 자유게시판)
  - 페이징 구현

![제목 없음12](https://github.com/nacknock/festival_project/assets/151377332/65773e17-86e8-4a9e-8689-cde8f2f808e1)

* __게시글 상세화면__
  - 게시글, 댓글, 해당하는 게시판 순서로 배치

![제목 없음14](https://github.com/nacknock/festival_project/assets/151377332/9ee4d7a0-adb9-4312-ab53-1e7cb667931f)
