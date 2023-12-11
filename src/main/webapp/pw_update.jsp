<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
  <head>
  	<title>id_check</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="css/style.css">

	<style>
	
	</style>
	</head>
	<body style="background-color:#95E0C8;">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-12 col-lg-10">
					<div class="wrap d-md-flex">
						
						<div class="login-wrap p-4 p-md-5" style="width:100%">
			      	<div class="d-flex">
			      		<div class="w-100" style="text-align:center">
			      			<h3 class="mb-4">변경할 비밀번호를 입력해주세요.</h3>
			      		</div>
								
			      	</div>
							<form method="post" action="pw_up_Action.jsp" class="signin-form">
		            <div class="form-group mb-3">
		            	<label class="label" for="password">P W(영어,숫자,특수문자조합 8-16자)</label>
		              <input type="password" class="form-control" name="pw" placeholder="pw" required
		              		pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$">
		            </div>
		            <div class="form-group">
		            <div class="form-group mb-3">
		            	<label class="label" for="password">P W 확 인</label>
		              <input type="password" class="form-control" name="pw_re" placeholder="pw_re" required>
		            </div>
		            <div class="form-group">
		            	<button type="submit" class="form-control btn btn-primary rounded submit px-3 btn_color">확인</button>
		            	<button type="button" class="form-control btn btn-primary rounded submit px-3 btn_color"
		            			onclick="javascript:history.back();"style="margin-top:10px;">취소</button>	
		            </div>
		            <div class="form-group d-md-flex">
		            	<div class="w-50 text-left">
			            	<!-- <label class="checkbox-wrap checkbox-primary mb-0">Remember Me
									  <input type="checkbox" checked>
									  <span class="checkmark"></span>
										</label> -->
									</div>
		            </div>
		          </form>
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

