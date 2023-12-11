<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="soloproject2.userDAO"%>

<%@ page import="soloproject2.user"%>

<%@ page import="java.io.PrintWriter"%>

<!doctype html>
<html lang="ko">
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
%>
  <head>
  	<title>Sign Up 10</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="../soloproject2/css/signup/css/style_join.css">
	
	<script type="text/javascript">
//////////////자동시작할 스크립트////////////////
    window.onload=function() {
        var str = '';
//////////////삭제시 입력할 문구 랜덤 생성///////////
            for (var i = 0; i < 8; i++) {
                str += Math.floor(Math.random() * 36).toString(36);
            }

        $('input[name=random]').attr('value',str);
    }
	</script>
	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-10" style="max-width:50%">
					<div class="wrap d-md-flex">
						<div class="login-wrap p-4 p-md-5" style="width:100%;text-align:center;">
	      			<h3 class="mb-3"><b>회원 탈퇴</b></h3>
	      			<!-- //////////////삭제시 경고 문구/////////// -->
		            <font color="red">
		            ※※※※※
		            <br>
		            계정을 삭제할 시 회원님의 모든 데이터가 영구적으로 삭제됩니다.
		            <br>
		            삭제된 데이터는 복구할 수 없으므로
		            <br>
		            신중히 결정하시기 바랍니다.
		            <br>
		            ※※※※※
		            </font>
		            <!-- //////////////삭제시 랜덤 값 입력 문구/////////// -->
		            <br>
		            <a id="random_code">삭제를 위해 아래 문구를 정확히 입력해주세요.</a>
		<!-- //////////////삭제시 입력할 랜덤 값/////////// -->
		<!--oncontextmenu='return false'우클릭 방지 적용-->
		            <input class="form-control" id="random_out" name="random" type="text" value="" 
		              readonly  oncontextmenu='return false'>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group d-flex align-items-center">
					      			<input type="text" class="form-control" id="random_in" name="name" placeholder="위 문구를 똑같이 입력하세요" required>
					      		</div>
									</div>
									
									<div class="col-md-12">
										<div class="form-group">
				            	<button type="button" class="btn btn-secondary submit p-3" onclick="inout_chk()">계정 삭제</button>
				            	<button type="button" class="btn btn-secondary submit p-3"
				            			onclick="location.href='user_data.jsp'">취&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp소</button>
				            </div>
									</div>
								</div>
								
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
  <!-- //////////////삭제버튼 눌렀을시 스크립트/////////// -->
	<script>
	    function inout_chk(){
	        var output = document.getElementById('random_out').value;
	        var input = document.getElementById('random_in').value;
	            if(output==input){
	                if (window.confirm('정말 탈퇴하시겠습니까?'))
	                {
	                    // They clicked Yes
	                    location.href='user_delete_Action.jsp';
	                }
	                else
	                {
	                    // They clicked no
	                }
	            }
	            else{
	                alert("코드가 일치하지 않습니다.");
	            }    
	    }
	    
	</script>
	</body>
</html>