<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<h2 class="heading-section">회&nbsp원&nbsp가&nbsp입</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-10">
					<div class="wrap d-md-flex">
						<div class="text-wrap p-4 p-lg-5 d-flex img d-flex align-items-end" style="background-image: url(../soloproject2/css/signup/images/bg123.jpg);">
							
			      </div>
						<div class="login-wrap p-4 p-md-5">
	      			<h3 class="mb-3"><b>회원가입</b></h3>
							<form method="post" action="joinAction.jsp" class="signup-form">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center" style="margin-bottom:0px;">
					      			<label class="label" for="name"><b>ID</b></label>
					      			<input type="text" class="form-control" name="id" placeholder="ID" required
					      			pattern="^[a-z0-9]{5,12}$">
					      		</div>
					      		<font color="">ID : 영어,숫자 조합 5-12자</font>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center"  style="margin-bottom:0px;">
					      			<label class="label" for="email">Password</label>
					      			<input type="password" class="form-control" name="pw" placeholder="Password" required
					      				pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$">
					      		</div>
					      		<font color="">PW : 영어,숫자,특수문자조합 8-16자</font>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					      			<label class="label" for="phone"><b>Password 확인</b></label>
					      			<input type="password" class="form-control" name="pw_re" placeholder="Password" required>
					      		</div>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					      			<label class="label" for="website"><b>닉네임</b></label>
					      			<input type="text" class="form-control" name="nickname" placeholder="닉네임" required>
					      		</div>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					      			<label class="label" for="website">이름</label>
					      			<input type="text" class="form-control" name="name" placeholder="이름" required>
					      		</div>
									</div>
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					            	<label class="label" for="password">Email</label>
					              	<input type="text" class="form-control" name="email" placeholder="johndoe@email.com" required
					              	pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*">
					            </div>
									</div>
									
									
									<div class="col-md-12">
										<div class="form-group">
				            	<button type="submit" class="btn btn-secondary submit p-3">가&nbsp&nbsp입&nbsp&nbsp하&nbsp&nbsp기</button>
				            </div>
									</div>
								</div>

		          </form>
		          <div class="w-100 text-center">
								<p class="mt-4">이미 회원이신가요? <a href="login_page.jsp">로그인</a></p>
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

