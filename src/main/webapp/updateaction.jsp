<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="board.boardDAO"%>

<%@ page import="board.Board"%>

<%@ page import="java.io.PrintWriter"%>

<%

request.setCharacterEncoding("UTF-8");

//sresponse.setContentType("text/html; charset=UTF-8");

%>

<!DOCTYPE html>

<html lang="ko">

<head>

​

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>게시판 웹사이트</title>

</head>

<body>

<%

String id = null;

if (session.getAttribute("id") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

	id = (String) session.getAttribute("id");//유저아이디에 해당 세션값을 넣어준다.

}

if (id == null) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('로그인한 경우에만 이용할 수 있습니다')");

script.println("location.href = 'login.jsp'");

script.println("</script>");

} 

//글이 유효한지 판별
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

} else {

	if (request.getParameter("b_title") == null || request.getParameter("b_content") == null
	
	|| request.getParameter("b_title").equals("") || request.getParameter("b_content").equals("") ) {
	
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('입력이 안된 사항이 있습니다')");
		
		script.println("history.back()");
		
		script.println("</script>");
	
	} else {
	
		boardDAO boardDAO = new boardDAO();
		
		int result = boardDAO.update(b_num, animal, request.getParameter("b_title"), request.getParameter("b_content"));
		
		if (result == -1) {
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('글수정에 실패했습니다')");
		
		script.println("history.back()");
		
		script.println("</script>");
	
	} else {
		
		%>
		<script>
		var b_num=<%= b_num %>
		var animal="<%= animal %>"
		var b_numS = b_num+""
		var getP=b_numS+"&&animal="+animal;
		location.href="view.jsp?b_num="+getP;
		</script>
		<%
		
	}
	
	}
	
}

%>

</body>

</html>