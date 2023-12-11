<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.boardDAO"%>
<%@ page import="board.Board"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
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
  	</style>
<!-- 검색창 -->
    <link href="search_bar/css/main.css" rel="stylesheet" />
<style>
.th_board{
text-align : center;
}

#board_title:link {
  color : black;
  text-decoration: none;
}
#board_title:visited {
  color : pink;
  text-decoration: none;
}
#board_title:hover {
  color : black;
  text-decoration: underline;
}
#board_title:active {
  color : 6df6ea;
  text-decoration: none;
}

</style>
<title>Insert title here</title>
</head>
<body>
<%
String nickname = "";

if (session.getAttribute("nickname") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

nickname = (String) session.getAttribute("nickname");//유저아이디에 해당 세션값을 넣어준다.

}

String  animal = request.getParameter("animal");

if(animal==null){
	PrintWriter script = response.getWriter();

	script.println("<script>");

	script.println("alert('잘못된 접근입니다.메인 페이지로 이동합니다.')");

	script.println("location.href='first_main.jsp'");

	script.println("</script>");
}
//로긴한사람이라면  userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
String id = null;

if (session.getAttribute("id") != null) {

id = (String) session.getAttribute("id");

}

int pageNumber = 1; //기본 페이지 넘버

//페이지넘버값이 있을때
if (request.getParameter("pageNumber") != null) {
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
		<div class="col-md-10 search s131">
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
<%
//라긴안된경우

if (id == null) {

%>
		<!---------------------------로그인------------------------------->
		<div class="col-md-2 login_box" style="padding-top:15px;">
					<button class="login_btn" onclick="javascript:location.href='login_page.jsp'">로그인</button>
					<button class="login_btn" onclick="javascript:location.href='signup.jsp'">회원가입</button>
				
		</div>
<%
//로그인 된경우
} else {

%>
		<!---------------------------로그인------------------------------->
		<div class="col-md-2 login_box">
					<font color="black"><%= nickname %> 님 환영합니다.</font>
					<button class="login_btn" onclick="javascript:location.href='user_data.jsp'">회원정보</button>
					<button class="login_btn" onclick="javascript:location.href='logout.jsp'">로그아웃</button>
				
		</div>
<%

}

%>
</div>
<div class="container"  id="tables">
<% 
	if(animal.equals("doggy")){
%>
<div style="margin-top:20px;margin-bottom:20px;"><h2>강아지</h2></div>
<%
	}else if(animal.equals("cat")){
%>
<div style="margin-top:20px;margin-bottom:20px;"><h2>고양이</h2></div>
<%
	}else if(animal.equals("etc")){
%>
<div style="margin-top:20px;margin-bottom:20px;"><h2>그 외</h2></div>
<%
	}else if(animal.equals("free")){
%>
<div style="margin-top:20px;margin-bottom:20px;"><h2>자유게시판</h2></div>
<%
	}
%>
	<table class="table table-bordered table-hover">
	        <thead>
	            <tr class="something">
	                <th style="width: 7%; text-align: center"><b>번호</b></th>
	                <th style="width: 48%; text-align: center"><b>제목</b></th>
	                <th style="width: 17.5%; text-align: center"><b>글쓴이</b></th>
	                <th style="width: 17.5%; text-align: center"><b>작성일</b></th>
	                <th style="width: 12%; text-align: center"><b>조회수</b></th>
	            </tr>
	        </thead>
	        <tbody>
        		<%
        			boardDAO boardDAO = new boardDAO();
					ArrayList<Board> list = boardDAO.getList(pageNumber,animal);
					for (int i = 0; i < list.size(); i++) {
						//System.out.println("i:"+ i);
				%>
	            <tr class="something">
	                <th class="th_board" style="width: 7%"><%=list.get(i).getB_num()%></th><!-- 글번호 -->
	                <th class="th_board" id="th_title" style="width: 48%"><a href="view.jsp?b_num=<%=list.get(i).getB_num()%>&&animal=<%= animal %>" id="board_title"><%=list.get(i).getB_title()%></a></th><!-- 글제목 -->
	                <th class="th_board" style="width: 17.5%"><%=list.get(i).getB_user_name()%></th><!-- 글쓴이 -->
	                <th class="th_board" style="width: 17.5%"><%=list.get(i).getB_date().substring(0, 11) + list.get(i).getB_date().substring(11, 13) + ":"
							+ list.get(i).getB_date().substring(14, 16)%></th><!-- 날짜 -->
					<th class="th_board" style="width: 12%"><%=list.get(i).getViews()%></th><!-- 조회수 -->
	            </tr>
            		<%
						}
					%>
	        </tbody>
	</table>
	</hr>
	<div style="display:flex">
<!-- 페이지 넘기기 -->
				<%
				boardDAO boardDAO7 = new boardDAO();
				int size=boardDAO.getNext(animal);
					if(size>10){

					if (pageNumber != 1) {

				%>

				<a href="doggy_board.jsp?pageNumber=<%=pageNumber - 1%>&&animal=<%= animal %>"

					class="btn btn-success btn-arrow-left" style="margin-right:auto">이전</a>

				<%

					}

					if (boardDAO.nextPage(pageNumber,animal)) {

				%>

				<a href="doggy_board.jsp?pageNumber=<%=pageNumber + 1%>&&animal=<%= animal %>"

					class="btn btn-success btn-arrow-left" style="margin-right:auto">다음</a>

				<%

					}
				%>	
<%
					}else{
						%>
						
						<a href="doggy_board.jsp?pageNumber=<%=pageNumber - 1%>&&animal=<%= animal %>"

							class="btn btn-success btn-arrow-left" style="margin-right:auto;visibility:hidden">이전</a>
							
						<a href="doggy_board.jsp?pageNumber=<%=pageNumber + 1%>&&animal=<%= animal %>"

							class="btn btn-success btn-arrow-left" style="margin-right:auto;visibility:hidden">다음</a>
						<%
							
						if (id == null) {

						%>
						
						<%
						//로그인 된경우
						} else {
						
						%>
							<button style="margin-left:auto;visibility:hidden" class="btn btn-default float-end" onclick="javascript:location.href='write_page.jsp?animal=<%= animal %>'">글쓰기</button>
						<%
						
							}
						}
						
//라긴안된경우

if (id == null) {

%>

<%
//로그인 된경우
} else {

%>
	<button style="margin-left:auto" class="btn btn-default float-end" onclick="javascript:location.href='write_page.jsp?animal=<%= animal %>'">글쓰기</button>
<%

}

%>

	</div>
	<%
	if(size>10){
		
	%>
	<!-- 페이지 번호 -->
	<div class="float-none">
		<ul class="pagination text-center">
			<li class="page-item"><a class="page-link" href="doggy_board.jsp?pageNumber=1&&animal=<%= animal %>">1</a></li>
			<li class="page-item"><a class="page-link" href="doggy_board.jsp?pageNumber=2&&animal=<%= animal %>">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
		</ul>
	</div>
	<%
	}else{
	%>
	<!-- 페이지 번호 -->
	<div class="float-none">
		<ul class="pagination text-center" style="visibility:hidden">
			<li class="page-item"><a class="page-link" href="doggy_board.jsp?pageNumber=1&&animal=<%= animal %>">1</a></li>
			<li class="page-item"><a class="page-link" href="doggy_board.jsp?pageNumber=2&&animal=<%= animal %>">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
		</ul>
	</div>
	<%
	}
	%>
	
</div>

	<footer>
			<address>
				 <strong>Twitter, Inc.</strong><br> 795 Folsom Ave, Suite 600<br> San Francisco, CA 94107<br> <abbr title="Phone">P:</abbr> (123) 456-7890
			</address>
	</footer>
</div>
<!-- bootstrap_js -->
<script src="js/jquery.min.js"></script>
<script src="search_bar/js/extention/choices.js"></script>
    <script>
      const choices = new Choices('[data-trigger]',
      {
        searchEnabled: false
      });

    </script>
</body>
</html>