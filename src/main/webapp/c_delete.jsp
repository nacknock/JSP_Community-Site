<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="board.boardDAO"%>

<%@ page import="board.Board"%>

<%@ page import="java.io.PrintWriter"%>

<%

request.setCharacterEncoding("UTF-8");

//response.setContentType("text/html; charset=UTF-8");

%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

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

int c_num = 0;

if (request.getParameter("c_num") != null) {

	c_num = Integer.parseInt(request.getParameter("c_num"));

}
if (c_num == 0) {

%>
<script>
alert('유효하지 않은 댓글 입니다.');
history.back();
</script>
<%

}else{

boardDAO boardDAO = new boardDAO();

int result = boardDAO.delete_comm(b_num,c_num,animal);

if (result == -1) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('글 삭제에 실패했습니다')");

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

%>

</body>

</html>