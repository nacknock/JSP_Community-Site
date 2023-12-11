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
</style>
<title>Insert title here</title>
</head>
<body>
<%
//
String b_search=null;
if (request.getParameter("b_search") != null) {
	request.setCharacterEncoding("utf-8");
	b_search = request.getParameter("b_search");
}
String search=null;
if (request.getParameter("choices-single-defaul") != null) {
	search = request.getParameter("choices-single-defaul");
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
					<a><%=id %> 님 환영합니다.</a>
					<button onclick="javascript:location.href='user_data.jsp'">회원정보</button>
					<button onclick="javascript:location.href='logout.jsp'">로그아웃</button>
				
		</div>
<%

}

%>
</div>
<div class="container" id="tables">
<div style="margin-top:20px;margin-bottom:20px;"><h2>검색 결과</h2></div>
	<table class="table table-bordered table-hover">
		<%
        			boardDAO boardDAO = new boardDAO();
					ArrayList<Board> list = boardDAO.getList_search(pageNumber,b_search,search);
					if(list.size()==0){
		%>
					<b><h4>검색 결과가 없습니다.</h4></b>
					<br>
					<br>
					<b><h4>-단어가 정확한지 확인하세요.</h4></b>
					<br>
					<b><h4>-다른 검색어를 사용해보세요.</h4></b>
					<br>
					<b><h4>-검색 범위를 바꿔보세요.</h4></b>
				<%		
					}else{
				%>
	        <thead>
	            <tr class="something">
	                <th style="width: 7%; text-align: center"><b>번호</b></th>
	                <th style="width: 12%; text-align: center"><b>게시판</b></th>
	                <th style="width: 36%; text-align: center"><b>제목</b></th>
	                <th style="width: 17.5%; text-align: center"><b>글쓴이</b></th>
	                <th style="width: 17.5%; text-align: center"><b>작성일</b></th>
	                <th style="width: 12%; text-align: center"><b>조회수</b></th>
	            </tr>
	        </thead>
	        <tbody>
        		<%				
					for (int i = 0; i < list.size(); i++) {
						//System.out.println("i:"+ i);
				%>
	            <tr class="something">
	                <th class="th_board" style="width: 7%"><%=10-i%></th><!-- 글번호 -->
	            <%
	            if(list.get(i).getB_board().equals("doggy")){
	            %>
	                <th class="th_board" style="width: 12%">강아지</th><!-- 게시판 -->
	            <%
	            }else if(list.get(i).getB_board().equals("cat")){
	            %>
	                <th class="th_board" style="width: 12%">고양이</th><!-- 게시판 -->
	            <%
	            }else if(list.get(i).getB_board().equals("etc")){
	            %>
	                <th class="th_board" style="width: 12%">그 외</th><!-- 게시판 -->
	            <%
	            }else if(list.get(i).getB_board().equals("free")){
	            %>
	                <th class="th_board" style="width: 12%">자유</th><!-- 게시판 -->
	            <%
	            }
	            %>
	                <th class="th_board" id="th_title" style="width: 36%"><a href="view.jsp?b_num=<%=list.get(i).getB_num()%>&&animal=<%= list.get(i).getB_board() %>" id="board_title"><%=list.get(i).getB_title()%></a></th><!-- 글제목 -->
	                <th class="th_board" style="width: 17.5%"><%=list.get(i).getB_user_name()%></th><!-- 글쓴이 -->
	                <th class="th_board" style="width: 17.5%"><%=list.get(i).getB_date().substring(0, 11) + list.get(i).getB_date().substring(11, 13) + ":"
							+ list.get(i).getB_date().substring(14, 16)%></th><!-- 날짜 -->
					<th class="th_board" style="width: 12%"><%=list.get(i).getViews()%></th><!-- 조회수 -->
	            </tr>
            		<%
						}
					}
					%>
	        </tbody>
	</table>
	</hr>
	
<!-- 페이지 넘기기 -->
				<%
				boardDAO boardDAO7 = new boardDAO();
				int size=boardDAO.getNext_search(b_search,search);
					if(size>10){
				%>
				
				<%

					if (pageNumber != 1) {

				%>

				<a href="search_result.jsp?pageNumber=<%=pageNumber - 1%>&&b_search=<%= b_search %>&&choices-single-defaul=<%= search %>"

					class="btn btn-success btn-arrow-left">이전</a>

				<%

					}

					if (boardDAO.nextPage_S(pageNumber,b_search,search)) {

				%>

				<a href="search_result.jsp?pageNumber=<%=pageNumber + 1%>&&b_search=<%= b_search %>&&choices-single-defaul=<%= search %>"

					class="btn btn-success btn-arrow-left">다음</a>

				<%

					}

				%>
	<!-- 페이지 번호 -->
	<div class="float-none">
		<ul class="pagination text-center">
			<li class="page-item"><a class="page-link" href="search_result.jsp?pageNumber=1&&b_search=<%= b_search %>&&choices-single-defaul=<%= search %>">1</a></li>
			<li class="page-item"><a class="page-link" href="search_result.jsp?pageNumber=2&&b_search=<%= b_search %>&&choices-single-defaul=<%= search %>">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
		</ul>
	</div>
				<%
					}else{
				%>
				
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