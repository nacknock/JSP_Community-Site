<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="soloproject2.userDAO" %> <!-- userdao의 클래스 가져옴 -->
	<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
	<% request.setCharacterEncoding("UTF-8"); %>
	<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
	
	<jsp:useBean id="user" class="soloproject2.user" scope="page" />
	
	<jsp:setProperty name="user" property="id" />
	
	<jsp:setProperty name="user" property="pw" />
	
	<jsp:setProperty name="user" property="pw_re" />
	
	<jsp:setProperty name="user" property="nickname" />
	
	<jsp:setProperty name="user" property="name" />
	
	<jsp:setProperty name="user" property="email" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

userDAO userDAO = new userDAO(); //인스턴스생성
///비밀번호 체크
int chk = userDAO.Pwchk(user.getPw(), user.getPw_re());

if(chk == 2){
PrintWriter script = response.getWriter();

script.println("<script>");

script.println("alert('비밀번호가 서로 다릅니다.')");

script.println("history.back()");

	script.println("</script>");
}
else{//idcheck
		int idchk = userDAO.idchk(user.getId());
		if(idchk ==0){
		PrintWriter script = response.getWriter();
	
		script.println("<script>");
	
		script.println("alert('이미 존재하는 아이디 입니다.')");
	
		script.println("history.back()");
	
		script.println("</script>");
		}
		else if(idchk == -2){
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('DB오류가 발생했습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
		} 
		else{//db오류
					int ninkchk = userDAO.nickchk(user.getNickname());
					if(ninkchk ==0){
					PrintWriter script = response.getWriter();
				
					script.println("<script>");
				
					script.println("alert('이미 존재하는 닉네임 입니다.')");
				
					script.println("history.back()");
				
					script.println("</script>");
					}
					else if(ninkchk == -2){
					
					PrintWriter script = response.getWriter();
					
					script.println("<script>");
					
					script.println("alert('DB오류가 발생했습니다.')");
					
					script.println("history.back()");
					
					script.println("</script>");
					
					}
					else{
							int result = userDAO.join(user);
							if(result == -1){
							
							PrintWriter script = response.getWriter();
							
							script.println("<script>");
							
							script.println("alert('데이터베이스 오류 입니다.')");
							
							script.println("history.back()");
							
							script.println("</script>");
							
							}
							
							
							//가입성공
							
							else {
							
							PrintWriter script = response.getWriter();
							
							script.println("<script>");
							
							script.println("alert('회원가입 성공')");
							
							script.println("location.href='login_page.jsp'");
							
							script.println("</script>");
							
							}
					}
		}
}
%>
</body>
</html>