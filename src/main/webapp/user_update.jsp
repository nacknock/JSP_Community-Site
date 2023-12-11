<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="soloproject2.userDAO"%>

<%@ page import="soloproject2.user"%>

<%@ page import="java.io.PrintWriter"%>

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
String name = user.getName();
String email = user.getEmail();
%>

<!doctype html>
<html lang="ko">
  <head>
  	<title>Sign Up 10</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="../soloproject2/css/signup/css/style_join.css">

	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">회원 정보 수정</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-10" style="max-width:50%">
					<div class="wrap d-md-flex">
						<div class="login-wrap p-4 p-md-5" style="width:100%">
	      			<h3 class="mb-3"><b>회원 정보 수정</b></h3>
							<form method="post" action="user_update_Action.jsp" class="signup-form">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					      			<label class="label" for="website">이름</label>
					      			<input type="text" class="form-control" name="name" placeholder="이름" required value="<%= name %>">
					      		</div>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					            	<label class="label" for="password">Email</label>
					              	<input type="text" class="form-control" name="email" placeholder="johndoe@email.com" required value="<%= email %>"
					              		   pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*">
					            </div>
									</div>
									
									
									<div class="col-md-12">
										<div class="form-group">
				            	<button type="submit" class="btn btn-secondary submit p-3">수정 완료</button>
				            	<button type="button" class="btn btn-secondary submit p-3"
				            			onclick="location.href='user_data.jsp'">취&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp소</button>
				            </div>
									</div>
								</div>

		          </form>
		          <div class="w-100 text-center">
		          </div>
		        </div>
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

	</body>
</html>

