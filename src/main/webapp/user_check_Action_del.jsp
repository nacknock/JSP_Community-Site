<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

​

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="user" class="soloproject2.user" scope="page" />

<jsp:setProperty name="user" property="pw" />

<%

String id = null;

if (session.getAttribute("id") != null) {

id = (String) session.getAttribute("id");



}

//라긴안된경우

if (id == null) {


%>
<script>
alert("로그인한 경우에만 이용할 수 있습니다");
location.href="login_page.jsp";
</script>
<%
}
%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

<%

userDAO userDAO = new userDAO(); //인스턴스생성

int result = userDAO.login(id, user.getPw());
//String idtest = user.getId();

//체크 성공

if(result == 1){
	
PrintWriter script = response.getWriter();

script.println("<script>");

script.println("location.href='user_delete.jsp'");

script.println("</script>");

}

else if(result == 0){

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('비밀번호가 틀립니다.')");

script.println("history.back()");

script.println("</script>");
}

else if(result == -1){

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('아이디를 불러오는 과정에서 문제가 발생했습니다.\n한 번 다시 로그인 한 후 시도하시기 바랍니다.')");

script.println("location.href='login_page.jsp'");

script.println("</script>");
}

else if(result == -2){

PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('DB오류가 발생했습니다./n관리자에게 문의해주세요.')");

script.println("history.back()");

script.println("</script>");

} 

%>

​

</body>

​

</html>