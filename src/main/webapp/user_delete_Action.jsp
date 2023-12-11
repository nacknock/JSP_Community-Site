<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO"%>

<%@ page import="soloproject2.user"%>

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
user user = new userDAO().getuser(id);
if (!id.equals(user.getId())) {

	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('권한이 없습니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");

}
else{

userDAO userDAO = new userDAO();

int result = userDAO.user_delete(id);

if (result == -1) {

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('계정 삭제에 실패했습니다')");

script.println("history.back()");

script.println("</script>");

} else {

session.removeAttribute("id");

session.removeAttribute("nickname");
	
PrintWriter script = response.getWriter();

script.println("<script>");

script.println("location.href='first_main.jsp'");

script.println("</script>");

}

}

%>

</body>

</html>