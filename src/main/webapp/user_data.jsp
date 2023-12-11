<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.boardDAO"%>

<%@ page import="board.Board"%>

<%@ page import="java.util.ArrayList"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Bootstrap 4, from LayoutIt!</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">
<!---------------------- css&bootstrap ------------------------->
<!-- 메인페이지 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/first_main.css" rel="stylesheet">
    <link href="css/main_nav.css" rel="stylesheet">
    <style>
  	#wrap{
	  	min-height: 100vh;
	    position: relative;
	    width: 100%;
	    margin: 0;
	  padding: 0;
  	}
  	footer {
		width: 100%;
		height: 120px; /* 내용물에 따라 알맞는 값 설정 */
		bottom: 0px;
		position: absolute;
		background-color:#95E0C8;
	}
	#tables {
		padding-bottom: 120px; /* footer의 height값과 동일 */
	}
	html, body {
	  margin: 0;
	  padding: 0;
	}
	.tableset{
		margin-bottom: 25px;
    	margin-top: 25px;
    	border-radius: 10px;
    	border: solid #EBE5E4 3px;
    	background:#EBE5E4;
	}
	.user_btn{
		width: 310px;
	    height: 80px;
	    margin: 10px 0px 10px 0px;
	    font-size: 30px;
	}
  	</style>
<!-- 검색창 -->
    <link href="search_bar/css/main.css" rel="stylesheet" />
  </head>
  <body>
<%

//로긴한사람이라면  userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

String id = null;
if (session.getAttribute("id") != null) {

id = (String) session.getAttribute("id");



}else{
	%>
	<script>
	alert("로그인한 경우에만 이용할 수 있습니다");
	location.href="login.jsp";
	</script>
	<%
}
String nickname = "";

if (session.getAttribute("nickname") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

nickname = (String) session.getAttribute("nickname");//유저아이디에 해당 세션값을 넣어준다.

}

%>
    <div class="container-fluid" id="wrap">
	<div class="row rowP">
		<div class="col-md-12">
		</div>
	</div>
	<div class="row menu_box">
	<!---------------------------네비게이션 바------------------------------->
	<header style="margin-left:17px;">
  		<div class="container2">
    		<div class="logo-box">
    		</div>
    		<nav>
    			<ul class="nav_ul">
			      <li class="nav_li"><a href="first_main.jsp">home</a></li>
			      <li class="nav_li"><a href="doggy_board.jsp?animal=doggy">강아지</a></li>
			      <li class="nav_li"><a href="doggy_board.jsp?animal=cat">고양이</a></li>
			      <li class="nav_li"><a href="doggy_board.jsp?animal=etc">그 외</a></li>
			      <li class="nav_li"><a href="doggy_board.jsp?animal=free">자유</a></li>
   				</ul>
  			</nav>
  			</div>
	</header>
	<!---------------------------검색------------------------------->
		<div class="col-md-10 search s131" style="margin-bottom:14px;">
     		<form method="get" action="search_result.jsp" id="search" accept-charset="UTF-8">
        <div class="inner-form" style="margin-left:130px;">
          <div class="input-field first-wrap">
            <input id="search" type="text" value="" name="b_search" />
          </div>
          <div class="input-field second-wrap">
            <div class="input-select">
              <select data-trigger="" name="choices-single-defaul">
                <option value="title" style="font-size:20px;">제목</option>
                <option value="user_name" style="font-size:20px;">글쓴이</option>
                <option value="content" style="font-size:20px;">내용</option>
              </select>
            </div>
          </div>
          <div class="input-field third-wrap">
            <button class="btn-search" type="submit">검색</button>
          </div>
        </div>
      </form>
		</div>
		<div class="col-md-2 login_box">
		</div>
	</div>
	<!---------------------------내가 쓴 글------------------------------->
	<div class="row tables"  id="tables">
		<div class="tableset" id="tableset1">
	
			<section>
			<li class="list list-title">내가 쓴 글</li>
	<%
    boardDAO boardDAO = new boardDAO();
	ArrayList<Board> list2 = boardDAO.getList_user_b(nickname);
	if(list2.size()<8){
		for (int i = 0; i < list2.size(); i++) {
	%>
			<li class="list"><a href="view.jsp?b_num=<%=list2.get(i).getB_num()%>&&animal=<%=list2.get(i).getB_board()%>"><%=list2.get(i).getB_title()%></a></li>
	<%
		}
	}else{
	for (int i = 0; i < 8; i++) {
		//System.out.println("i:"+ i);
	%>
			<li class="list"><a href="view.jsp?b_num=<%=list2.get(i).getB_num()%>&&animal=<%=list2.get(i).getB_board()%>"><%=list2.get(i).getB_title()%></a></li>
	<%
		}
	}
	%>
			</section>	
		</div>
	
		<!---------------------------나의 댓글------------------------------->
		<div class="tableset"  >
			<section>
			<li class="list list-title">나의 댓글</li>
	<%
	ArrayList<Board> list3 = boardDAO.getList_user_c(nickname);
	if(list3.size()<9){
		for (int i = 0; i < list3.size(); i++) {
	%>
			<li class="list"><a href="view.jsp?b_num=<%=list3.get(i).getB_num()%>&&animal=<%=list3.get(i).getB_board()%>"><%=list3.get(i).getB_content()%></a></li>
	<%
		}
	}else{
		for (int i = 0; i < 10; i++) {
		
		
	%>
			<li class="list"><a href="view.jsp?b_num=<%=list3.get(i).getB_num()%>&&animal=<%=list3.get(i).getB_board()%>"><%=list3.get(i).getB_content()%></a></li>
	<%
			}
	}
	%>
			</section>	
		</div>
		<!---------------------------회원 정보 관리------------------------------->
		<div class="tableset">
			<section>
			<li class="list list-title">회원 정보 관리</li>
	<button class="user_btn" onclick="javascript:location.href='user_check.jsp'"><span>회원 정보 수정</span></button>
	<button class="user_btn" onclick="javascript:location.href='user_check_del.jsp'"><span>회원 탈퇴</span></button>
			</section>	
		</div>
	</div>
	<!---------------------------빈공간------------------------------->
	<footer>
			<address>
				 <strong>Twitter, Inc.</strong><br> 795 Folsom Ave, Suite 600<br> San Francisco, CA 94107<br> <abbr title="Phone">P:</abbr> (123) 456-7890
			</address>
	</footer>
</div>
<!--bootstrap-->
<!--메인페이지-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
<!--검색창-->
	<script src="search_bar/js/extention/choices.js"></script>
    <script>
      const choices = new Choices('[data-trigger]',
      {
        searchEnabled: false
      });

    </script>
  </body>
</html>