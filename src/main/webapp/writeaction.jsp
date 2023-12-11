<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.boardDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.io.File"%>

<%@page import="java.util.Enumeration"%>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%

request.setCharacterEncoding("UTF-8");

response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>

​

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="board" class="board.Board" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="board" property="b_title" /><!-- bbs.setBbsTitle(requrst) -->

<jsp:setProperty name="board" property="b_content" />

<jsp:setProperty name="board" property="b_board" />
​<%

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

String nickname = null;

if (session.getAttribute("nickname") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

	nickname = (String) session.getAttribute("nickname");//유저아이디에 해당 세션값을 넣어준다.

}


if (nickname == null) {

	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('로그인시에만 작성 가능합니다.')");
	
	script.println("location.href = 'login_page.jsp'");
	
	script.println("</script>");

}

else {
	
	String fileName = "";
	String fileRealName = "";
	
	int b_num=0;
	
	b_num = (int) session.getAttribute("b_num");
	
	String uploadPath = request.getSession().getServletContext().getRealPath("./img_upload/"+b_num+"/");

	File targetDir = new File(uploadPath);
	if(!targetDir.exists()){
		targetDir.mkdirs();
	}

	int maxSize = 1024 * 1024 * 500;
	String encoding = "UTF-8";

	MultipartRequest multipartRequest
	= new MultipartRequest(request, uploadPath, maxSize, encoding,
					new DefaultFileRenamePolicy());

	fileName = multipartRequest.getOriginalFileName("b_img");
	fileRealName = multipartRequest.getFilesystemName("b_img");

	String b_title = multipartRequest.getParameter("b_title");
	String b_content = multipartRequest.getParameter("b_content");
	String b_board = multipartRequest.getParameter("b_board");
	
	board.setB_title(b_title);
	board.setB_content(b_content);
	board.setB_board(b_board);
	
	if(fileName != null && fileRealName != null){
		
		board.setB_img(fileName);
		board.setB_img_real(fileRealName);
		
		if (board.getB_title() == null || board.getB_content() == null) {
		
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('입력이 안된 사항이 있습니다')");
			
			script.println("history.back()");
			
			script.println("</script>");
		
		} else {
			
			boardDAO boardDAO = new boardDAO();
			
			int result = boardDAO.write_img(board.getB_title(), nickname, board.getB_content(), board.getB_board(),fileName,fileRealName);
		
			if (result == -1) {
			
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				
				script.println("alert('글쓰기에 실패했습니다 이미지')");
				
				script.println("history.back()");
				
				script.println("</script>");
			
			} else {
			
				%>
				<script>
				alert("img");
				var animal2 = "<%= board.getB_board() %>";
				location.href="doggy_board.jsp?animal="+animal2;
				</script>
				<%
			}
		
		}
		
	}else{
		if (board.getB_title() == null || board.getB_content() == null) {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('입력이 안된 사항이 있습니다')");
			
			script.println("history.back()");
			
			script.println("</script>");
		
		} else {
			
			boardDAO boardDAO = new boardDAO();
			
			int result = boardDAO.write(board.getB_title(), nickname, board.getB_content(), board.getB_board());
		
			if (result == -1) {
			
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				
				script.println("alert('글쓰기에 실패했습니다')");
				
				script.println("history.back()");
				
				script.println("</script>");
			
			} else {
			
				%>
				<script>
				alert("img none");
				var animal2 = "<%= board.getB_board() %>";
				location.href="doggy_board.jsp?animal="+animal2;
				</script>
				<%
			}
		
		}
	}

}

%>

</body>
</html>