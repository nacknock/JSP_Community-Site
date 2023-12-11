<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="soloproject2.user" scope="page" />

<jsp:setProperty name="user" property="id" />

<%

String id = "";

if (!user.getId() .equals("")) {

	id = user.getId();

	session.setAttribute("id", id);

}

//아이디나 이름을 못불러온 경우

if (id == "") {


	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('error code-cpu A')");
	
	script.println("history.back()");
	
	script.println("</script>");
	
}

String name = "";

	if(!request.getParameter("name").equals("")){
		
	name = request.getParameter("name");

}

if(name .equals("")){
	
	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('error code-cpu B')");
	
	script.println("history.back()");
	
	script.println("</script>");
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

int result = userDAO.chk_pw_update(id,name);

//체크 성공

if(result == 1){
	
	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("location.href='pw_update.jsp'");
	
	script.println("</script>");

}

else if(result == 0){

	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('해당하는 계정이 없습니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");
	
}

else if(result == -1){

	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('해당하는 계정이 없습니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");
	
}

else if(result == -2){

	PrintWriter script = response.getWriter();

	script.println("<script>");

	script.println("alert('DB오류가 발생했습니다.관리자에게 문의해주세요.')");

	script.println("history.back()");

	script.println("</script>");

} 

%>


</body>

​

</html>