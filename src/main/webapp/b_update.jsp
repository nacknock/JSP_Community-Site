<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.boardDAO"%>
<%@ page import="board.Board"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>Contact Form Template | PrepBootstrap</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" type="text/css" href="write_page/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="write_page/font-awesome/css/font-awesome.min.css" />
    <link href="css/main_nav.css" rel="stylesheet">
    <link href="css/first_main.css" rel="stylesheet">
    <style>
    .t_a{
    	resize:none;
    }
    </style>
    <script type="text/javascript" src="write_page/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="write_page/bootstrap/js/bootstrap.min.js"></script>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- get값 가져와서 js변수에 넣기 -->
    <script>

	var animal = <%request.getParameter("animal");%>
	//none input에 animal넣기
	window.onload=function(){
	$('input[name=b_board]').attr('value',animal);
	}
    </script>
</head>
<body>
<%
String animal = "";

if (request.getParameter("animal") != null) {

	animal = request.getParameter("animal");

}

if (animal == "") {

%>
<script>
alert('유효하지 않은 글 입니다.');
location.href="doggy_board.jsp?animal="+animal;
</script>
<%
}
int b_num = 0;

if (request.getParameter("b_num") != null) {

	b_num = Integer.parseInt(request.getParameter("b_num"));

}

if (b_num == 0) {

%>
<script>
alert('유효하지 않은 글 입니다.');
location.href="doggy_board.jsp?animal="+animal;
</script>
<%

}

Board board = new boardDAO().getBoard(b_num,animal);

if (b_num!=(board.getB_num())) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('권한이 없습니다.')");

script.println("history.back()");

script.println("</script>");

}

//로긴한사람이라면  userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

String id = null;

if (session.getAttribute("id") != null) {

id = (String) session.getAttribute("id");



}

//라긴안된경우

if (id == null) {


%>
<script>
alert("로그인한 경우에만 이용할 수 있습니다");
history.back();
</script>
<%
}else{
%>
<div class="container-fluid">
	<div class="row rowP">
		<div class="col-md-12">
			<h3 class="text-center">
				제목
			</h3>
		</div>
	</div>
<div class="row menu_box">
<!---------------------------네비게이션 바------------------------------->
	<header>
  		<div class="container2">
    		<!-- <div class="logo-box">
    		</div> -->
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
</div>
<div class="container">
<div class="page-header">
    
</div>

<!-- Contact Form - START -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="well well-sm">
                <form class="form-horizontal" method="post" action="updateaction.jsp?b_num=<%=b_num%>&&animal=<%=animal%>">
                    <fieldset>
                        <legend class="text-center header">글 수정</legend>
						<input name="b_board" value="" style="display:none">
                        <div class="form-group">
                            <span class="col-md-1 col-md-offset-2 text-center"><i class="fa fa-user bigicon"></i></span>
                            <div class="col-md-8">
                                <input id="fname" name="b_title" type="text" placeholder="제목" class="form-control" value="<%= board.getB_title() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <span class="col-md-1 col-md-offset-2 text-center"><i class="fa fa-pencil-square-o bigicon"></i></span>
                            <div class="col-md-8">
                                <textarea class="form-control t_a" id="message" name="b_content" placeholder="내용" rows="7" required><%= board.getB_content() %></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-12 text-center">
                                <button type="submit" class="btn btn-primary btn-lg">수정</button>
                                <button type="button" class="btn btn-primary btn-lg" onclick="javascript:history.back()">취소</button>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .header {
        color: #36A0FF;
        font-size: 27px;
        padding: 10px;
    }

    .bigicon {
        font-size: 35px;
        color: #36A0FF;
    }
</style>

<!-- Contact Form - END -->

</div>
<%
}
%>
</body>
</html>