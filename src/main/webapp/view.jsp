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
.t_a{
  resize:none;
}
.view_box{
  margin-bottom:20px;
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
//view
int b_num = 0;

if (request.getParameter("b_num") != null) {

	b_num = Integer.parseInt(request.getParameter("b_num"));

}

if (b_num == 0) {
	
%>
	<script>
	alert("유효하지 않은 글입니다.case-a");
	location.href="doggy_board.jsp?animal="+"<%= animal %>";
	</script>
<%

}

boardDAO boardDAO_view = new boardDAO();

int result = boardDAO_view.views_sel(b_num,animal);

if(result == -1){
	
%>
	<script>
	alert("유효하지 않은 글입니다.case-b");
	location.href="doggy_board.jsp?animal="+"<%= animal %>";
	</script>
<%

}

int result2 = boardDAO_view.views_up(b_num,result,animal);

if(result2 == -1){
	
%>
	<script>
	alert("유효하지 않은 글입니다.case-c");
	location.href="doggy_board.jsp?animal="+"<%= animal %>";
	</script>
<%

}
%>
<div class="container-fluid" id="wrap">
	<div class="row rowP">
		<div class="col-md-12">
		</div>
	</div>
	<div class="row menu_box">
	<!---------------------------네비게이션 바------------------------------->
	<!---------------------------네비게이션 바------------------------------->
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
	<!---------------------------검색------------------------------->
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

Board board = new boardDAO().getBoard(b_num,animal);
String user_name = board.getB_user_name();
%>
</div>

<!----------------------------- view ----------------------------------->
<!----------------------------- view ----------------------------------->
<!----------------------------- view ----------------------------------->
<div class="container view_box">
	<table class="table table-bordered table-hover">
		<tbody>
			 <tr class="something">
			 
				<th style="border-right: none; width:82%"><%= board.getB_title() %></th>
				 
				<th style="border-left: none; text-align:center; width:18%">조회수 <%= board.getViews() %></th>
				 
			 </tr>
			 <tr class="something">
			 	<th style="border-right: none;"><%= board.getB_user_name() %></th>
			 	
				<th style="border-left: none; text-align:center;">
					 <%= board.getB_date().substring(0, 11) + board.getB_date().substring(11, 13) + ":"
						+ board.getB_date().substring(14, 16)%>
				</th>
				
			 </tr>
		</tbody>
	</table>
	<div contentEditable="false" name="content" class="form-control t_a" style="background-color:white">
	<%
		if(board.getB_img_chk() == 1){
			String uploadPath = "./img_upload/"+b_num+"/"+board.getB_img();
	%>
			<img src="<%=uploadPath %>" style="width:100px;height:100px;">
	<%		
		}
	%>
	<%= board.getB_content() %>
	<textarea class="form-control t_a" id="message" name="b_content" rows="7" style="background-color:white; display:none" readonly disabled ><%= board.getB_content() %></textarea>
	</div>
<!----------------------------- 글쓰기,수정,삭제,목록 버튼 ----------------------------------->
<!----------------------------- 글쓰기,수정,삭제,목록 버튼 ----------------------------------->
<!----------------------------- 글쓰기,수정,삭제,목록 버튼 ----------------------------------->
<%
//라긴안된경우

if (id == null) {

%>
	<button id="update_btn" onclick="javascript:location.href='doggy_board.jsp?animal=<%= animal %>'">목록</button>
<%
//로그인 된경우
} else {
if(nickname.equals(board.getB_user_name())){
%>
	<button id="back_btn" onclick="javascript:location.href='doggy_board.jsp?animal=<%= animal %>'">목록</button>
	<button id="update_btn" onclick="javascript:location.href='b_update.jsp?b_num=<%= b_num %>&&animal=<%= animal %>'">수정</button>
	<button id="delete_btn" onclick="javascript:location.href='b_delete.jsp?b_num=<%= b_num %>&&animal=<%= animal %>'">삭제</button>
<%
}else{
%>
	<button id="back_btn" onclick="javascript:location.href='doggy_board.jsp?animal=<%= animal %>'">목록</button>
	<button style="margin-left:auto" class="btn btn-default float-end" onclick="javascript:location.href='write_page.jsp?animal=<%= animal %>'">글쓰기</button>
<%
}
}

%>
<!----------------------------- 댓글 ----------------------------------->
<!----------------------------- 댓글 ----------------------------------->
<!----------------------------- 댓글 ----------------------------------->
	<div>
		<table class="table table-bordered table-hover">
		<tbody>
		<%
			int c_num = 0;
      		boardDAO boardDAO = new boardDAO();
			ArrayList<Board> list_comm = boardDAO.getList_comm(animal,b_num);
			if(list_comm.size()<9){
				for (int i = 0; i < list_comm.size(); i++) {
					boolean chk=true;
						if(nickname.equals(list_comm.get(i).getB_user_name())){
							c_num = list_comm.get(i).getC_num();
							chk=false;
		%>
		<!----------------------------- 자신의 댓글 ----------------------------------->
			<tr>
			<!----------------------------- 댓글 구성요소 ----------------------------------->
				<th id="comment_name_<%=c_num%>" style="width: 10%"><%=list_comm.get(i).getB_user_name()%></th>
				<th id="comment_content_<%=c_num%>" style="width: 54%;">
					<%=list_comm.get(i).getB_content()%>
			<!----------------------------- 댓글 구성요소 끝 ----------------------------------->
					<!----------------------------- 댓글 삭제 form ----------------------------------->
					<form method="post" action="c_delete.jsp">
						<input style="display:none;" name="c_num" value="<%=c_num%>">
						<input style="display:none;" name="animal" value="<%=animal%>">
						<input style="display:none;" name="b_num" value="<%=b_num%>">
						<button style="float:right;width:17%;" type="submit">삭제</button>
					</form>
					<!----------------------------- 댓글 삭제 form 끝 ----------------------------------->
					<button style="float:right;width:17%;" onclick="c_update(<%=c_num%>)">수정</button>
					
				</th>
				<!----------------------------- 댓글 구성요소 ----------------------------------->
				<th id="comment_date_<%=c_num%>" style="width: 18%;text-align:center"><%= list_comm.get(i).getB_date().substring(0, 11) + board.getB_date().substring(11, 13) + ":"
						+ board.getB_date().substring(14, 16)%></th>
				<!----------------------------- 댓글 구성요소 끝 ----------------------------------->
						
				<!----------------------------- 수정버튼 눌렀을시 나오는 곳,댓글 수정 form ----------------------------------->
				<form style="display:none;" id="c_update_form_<%=c_num%>" method="post" action="c_update.jsp">
					<input style="display:none;" id="c_update_input1_<%=c_num%>" name="c_num" value="<%=list_comm.get(i).getC_num()%>">
					<input style="display:none;" id="c_update_input2_<%=c_num%>" name="animal" value="<%=animal%>">
					<input style="display:none;" id="c_update_input3_<%=c_num%>" name="b_num" value="<%=b_num%>">
					<textarea style="display:none;height:50px;background-color:white" id="c_update_ta_<%=c_num%>" class="form-control t_a" id="message" name="b_content" rows="7"><%=list_comm.get(i).getB_content()%></textarea>
					<button style="display:none;" id="c_update_btn1_<%=c_num%>" type="submit">수정</button>
					<button style="display:none;" id="c_update_btn2_<%=c_num%>" type="button" onclick="c_cancel(<%=c_num%>)">취소</button>
				</form>
				<!----------------------------- 댓글 수정 form 끝----------------------------------->
			</tr>
			
				
		<%				
						}
						if(chk){
		%>
		<!----------------------------- 타인의 댓글/댓글 10개 미만 ----------------------------------->
			<tr>
				<th style="width: 10%"><%=list_comm.get(i).getB_user_name()%></th>
				<th style="width: 72%"><%=list_comm.get(i).getB_content()%></th>
				<th style="width: 18%;text-align:center"><%= list_comm.get(i).getB_date().substring(0, 11) + board.getB_date().substring(11, 13) + ":"
						+ board.getB_date().substring(14, 16)%></th>
			</tr>
		<%
						
						}
				}
			}else{
				for (int i = 0; i < 10; i++) {
				//System.out.println("i:"+ i);
		%>
		<!----------------------------- 타인의 댓글/댓글 10개 이상 ----------------------------------->
			<tr>
				<th style="width: 10%"><%= board.getB_user_name() %></th>
				<th style="width: 72%"><%= board.getB_content() %></th>
				<th style="width: 18%;text-align:center"><%= board.getB_date().substring(0, 11) + board.getB_date().substring(11, 13) + ":"
						+ board.getB_date().substring(14, 16)%></th>
			</tr>
		<%
				}
			}
		%>
		</tbody>
		</table>
		<!----------------------------- 댓글 등록----------------------------------->
		<form method="post" action="comment_action.jsp">
			<input name="b_board" value="<%= animal %>" style="display:none"><!-- board -->
			<input name="b_num" value="<%= b_num %>" style="display:none"><!-- b_num -->
			<textarea class="form-control t_a ta_comm" id="message-c" name="b_content" rows="7" style="background-color:white;height:100px;"placeholder="댓글"></textarea>
			<button id="comm_btn" type="submit" >등록</button>
		</form>
	</div>
</div>
<!----------------------------- board ----------------------------------->
<!----------------------------- board ----------------------------------->
<!----------------------------- board ----------------------------------->
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
<!-- 페이지 넘기기 -->
				<%
				boardDAO boardDAO7 = new boardDAO();
				int size=boardDAO.getNext(animal);
					if(size>10){
				%>
				
				<%

					if (pageNumber != 1) {

				%>

				<a href="doggy_board.jsp?pageNumber=<%=pageNumber - 1%>&&animal=<%= animal %>"

					class="btn btn-success btn-arrow-left">이전</a>

				<%

					}

					if (boardDAO.nextPage(pageNumber,animal)) {

				%>

				<a href="doggy_board.jsp?pageNumber=<%=pageNumber + 1%>&&animal=<%= animal %>"

					class="btn btn-success btn-arrow-left">다음</a>

				<%

					}

				%>
	<!-- 페이지 번호 -->
	<!-- 페이지 번호 -->
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
				
				<%
					}
				%>
</div>
<!---------------------------빈공간------------------------------->
	<footer>
			<address>
				 <strong>Twitter, Inc.</strong><br> 795 Folsom Ave, Suite 600<br> San Francisco, CA 94107<br> <abbr title="Phone">P:</abbr> (123) 456-7890
			</address>
	</footer>
</div>
<!-- bootstrap_js -->
<!-- bootstrap_js -->
<!-- bootstrap_js -->
<script src="js/jquery.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 댓글 수정 함수 -->
<script>
function c_update(c_num){
	$('#comment_name_'+c_num).attr('style', "display:none;");  //숨기기
	$('#comment_content_'+c_num).attr('style', "display:none;");
	$('#comment_date_'+c_num).attr('style', "display:none;");
	$('#message-c'+c_num).attr('style', "display:none;");
	$('#comm_btn'+c_num).attr('style', "display:none;");

	$('#c_update_form_'+c_num).attr('style', "display:'';");  //나타내기
	$('#c_update_ta_'+c_num).attr('style', "display:'';");
	$('#c_update_btn1_'+c_num).attr('style', "display:'';");
	$('#c_update_btn2_'+c_num).attr('style', "display:'';");
	
}
function c_cancel(c_num){
	
	$('#comment_name_'+c_num).attr('style', "display:'';");  //나타내기
	$('#comment_content_'+c_num).attr('style', "display:'';");
	$('#comment_date_'+c_num).attr('style', "display:'';");
	$('#message-c'+c_num).attr('style', "display:'';");
	$('#comm_btn'+c_num).attr('style', "display:'';");

	$('#c_update_form_'+c_num).attr('style', "display:none;");  //숨기기
	$('#c_update_ta_'+c_num).attr('style', "display:none;");
	$('#c_update_btn1_'+c_num).attr('style', "display:none;");
	$('#c_update_btn2_'+c_num).attr('style', "display:none;");
	
}
</script>
<script src="search_bar/js/extention/choices.js"></script>
    <script>
      const choices = new Choices('[data-trigger]',
      {
        searchEnabled: false
      });

    </script>
</body>
</html>