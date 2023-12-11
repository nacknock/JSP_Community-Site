<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%

String id = null;

if(session.getAttribute("id") != null){
	
	id = (String) session.getAttribute("id");
	
}



//id 못받아온 경우

if (id == null) {


	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('error code-pu A')");
	
	script.println("history.back()");
	
	script.println("</script>");
}

String pw = null;

if (request.getParameter("pw") != null) {

	pw = request.getParameter("pw");



}

//pw 못받아온 경우

if (pw == null) {


	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('error code-pu B')");
	
	script.println("history.back()");
	
	script.println("</script>");
}

String pw_re = null;

	if(request.getParameter("pw_re") != null){
		
		pw_re = request.getParameter("pw_re");

}

if(pw_re == null){
	
	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('error code-pc C')");
	
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

if(pw.equals(pw_re)){

	userDAO userDAO = new userDAO(); //인스턴스생성
	
	int result = userDAO.pw_update(pw,id);
	
	//체크 실패
	
	if(result == -1){
	
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('데이터베이스 오류 발생.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
	}
	else{
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('비밀번호 변경 완료.')");
		
		script.println("location.href='login_page.jsp'");
		
		script.println("</script>");
		
	}
}else{
	
	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('비밀번호가 서로 다릅니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");
}
%>

​

</body>

​

</html>