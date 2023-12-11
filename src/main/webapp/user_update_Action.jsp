<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO"%>

<%@ page import="soloproject2.user"%>

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

//정보가 유효한지 판별
String name = "";

if (request.getParameter("name") != null) {

	name = request.getParameter("name");

}

if (name == "") {

%>
<script>
alert('오류!\n정보가 제대로 불러와지지 않았습니다.-1');
history.back();
</script>
<%
}
String email = "";

if (request.getParameter("email") != null) {

	email = request.getParameter("email");

}

if (email == "") {

%>
<script>
alert('오류!\n정보가 제대로 불러와지지 않았습니다.-2');
history.back();
</script>
<%
}

user user = new userDAO().getuser(id);
if (!id.equals(user.getId())) {

	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('권한이 없습니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");

} else {

	if (request.getParameter("name") == null || request.getParameter("email") == null
	
	|| request.getParameter("name").equals("") || request.getParameter("email").equals("") ) {
	
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('입력이 안된 사항이 있습니다')");
		
		script.println("history.back()");
		
		script.println("</script>");
	
	} else {
	
		userDAO userDAO = new userDAO();
		
		int result = userDAO.user_update(id,name,email);
		
		if (result == -1) {
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('글수정에 실패했습니다')");
		
		script.println("history.back()");
		
		script.println("</script>");
	
	} else {
		
		%>
		<script>
		alert('수정완료.');
		location.href="user_data.jsp";
		</script>
		<%
		
	}
	
	}
	
}

%>

</body>

</html>