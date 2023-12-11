<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.boardDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

request.setCharacterEncoding("UTF-8");

response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>

​

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="board" class="board.Board" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="board" property="b_num" /><!-- bbs.setBbsTitle(requrst) -->

<jsp:setProperty name="board" property="b_content" />

<jsp:setProperty name="board" property="b_board" />

​

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

​

<%

String nickname = null;

if (session.getAttribute("nickname") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

nickname = (String) session.getAttribute("nickname");//유저아이디에 해당 세션값을 넣어준다.

}


if (nickname == null) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('로그인시에만 작성 가능합니다.')");

script.println("history.back()");

script.println("</script>");

}
if (nickname.equals("-2")){
	
PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('데이터베이스 오류 발생')");

script.println("history.back()");

script.println("</script>");
}else {

if (board.getB_content() == null) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('입력된 사항이 없습니다')");

script.println("history.back()");

script.println("</script>");

} else {

boardDAO boardDAO = new boardDAO();

boardDAO.getNext_comm(board.getB_board(),board.getB_num());

int result = boardDAO.write_comm(board.getB_num(), nickname, board.getB_content(), board.getB_board());

if (result == -1) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('댓글 작성에 실패했습니다')");

script.println("history.back()");

script.println("</script>");

} else {

%>
<script>
		var b_num=<%= board.getB_num() %>
		var animal="<%= board.getB_board() %>"
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