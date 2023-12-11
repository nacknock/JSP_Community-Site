package soloproject2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.Board;

public class userDAO {
	private Connection conn=null; 
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;

	public userDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함

		try {
			String dbURL = "jdbc:mysql://localhost:3306/jsp_solo?useUnicode=true&characterEncoding=utf8"; 
			String dbID = "root";
			String dbPassword = "qwer";
			Class.forName("com.mysql.cj.jdbc.Driver"); //예전버전
			//Class.forName("com.mysql.cj.jdbc.Driver"); //최신버전
			
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 

		}
	}
	
	// 로그인을 시도하는 함수****
		public int login(String id, String pw) {
			String SQL = "SELECT pw FROM user_data WHERE id = ?";

			try {

				// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
				pstmt = conn.prepareStatement(SQL);			
				// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
				pstmt.setString(1, id);
				// rs:result set 에 결과보관
				rs = pstmt.executeQuery();
				// 결과가 존재한다면 실행
				if (rs.next()) {
					// 패스워드 일치한다면 실행
					if (rs.getString(1).equals(pw)) {
						return 1; // 로그인 성공
					} else
					{
						return 0; // 비밀번호 불일치
					}
				}			
				return -1; // 아이디가 없음 오류

			} catch (Exception e) {
				System.out.println("4444444444444444444");
				e.printStackTrace();
			}

			return -2; // 데이터베이스 오류를 의미
		}
		// 로그인시 닉네임 불러오기****
		public String loadname(String id) {
			String query = "SELECT nickname FROM user_data WHERE id = ?";
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					// 패스워드 일치한다면 실행
					String result = rs.getString(1);
					return result;
				}

				
			} catch (Exception e) {
				System.out.println("4444444444444444444");
				e.printStackTrace();
			}

			return "-2"; // 데이터베이스 오류를 의미
		}
		//Pw확인
		public int Pwchk(String pw, String pw_re) {
			if(pw.equals(pw_re)) {
				return 1;//같은 경우
			}
			return 2;//다른 경우
		}
		//id확인
		public int idchk(String id) {
			String SQL = "SELECT id FROM user_data WHERE id like ?";
			try {

				// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
				pstmt = conn.prepareStatement(SQL);			
				// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
				pstmt.setString(1, id);
				// rs:result set 에 결과보관
				rs = pstmt.executeQuery();
				// 결과가 존재한다면 실행
				if (rs.next()) {
					// 패스워드 일치한다면 실행
					if (rs.getString(1).equals(id)) {
						System.out.println("중복 아이디 검출");
						return 0; // 아이디 중복됨
					} else
					{
						System.out.println("중복 아이디 미검출");
						return 1; // 아이디 중복없음
					}
				}			
				return -1; // 입력된 아이디가 없음 오류

			} catch (Exception e) {
				System.out.println("4444444444444444444");
				e.printStackTrace();
			}

			return -2; // 데이터베이스 오류를 의미
		}
		//닉네임확인
		public int nickchk(String nickname) {
			String SQL = "SELECT nickname FROM user_data WHERE nickname like ?";
			try {

				// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
				pstmt = conn.prepareStatement(SQL);			
				// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
				pstmt.setString(1, nickname);
				// rs:result set 에 결과보관
				rs = pstmt.executeQuery();
				// 결과가 존재한다면 실행
				if (rs.next()) {
					// 패스워드 일치한다면 실행
					if (rs.getString(1).equals(nickname)) {
						System.out.println("중복 닉네임 검출");
						return 0; // 닉네임 중복됨
					} else
					{
						System.out.println("중복 닉네임 미검출");
						return 1; // 닉네임 중복없음
					}
				}			
				return -1; // 입력된 닉네임이 없음 오류

			} catch (Exception e) {
				System.out.println("4444444444444444444");
				e.printStackTrace();
			}

			return -2; // 데이터베이스 오류를 의미
		}
		// 회원가입
		public int join(user user) {
			String SQL = "INSERT INTO user_data(id,pw,nickname,name,email) VALUES (?,?,?,?,?)";

			try {

			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, user.getId());

			pstmt.setString(2, user.getPw());

			pstmt.setString(3, user.getNickname());

			pstmt.setString(4, user.getName());

			pstmt.setString(5, user.getEmail());

			return pstmt.executeUpdate();

			} catch (Exception e) {

			e.printStackTrace();

			}

			return -1; // DB 오류

			}
		
		//정보체크
		
		public user getuser(String id) {

			String SQL = "SELECT * FROM user_data WHERE id = ?";
			
			try {
				
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
				
					user user = new user();
					
					user.setId(rs.getString(2));
					
					user.setName(rs.getString(5));
					
					user.setEmail(rs.getString(6));
					
					
					
					return user;
					
				}
			
			} catch (Exception e) {
			
				e.printStackTrace();
			
			}
			System.out.println("getuser db error");
			return null;
			
			}
		
		//정보수정
		
		public int user_update(String id,String name, String email) {

			String SQL = "UPDATE user_data SET name = ?, email = ? WHERE id = ?";
			
			try {
			
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, name);
				
				pstmt.setString(2, email);
				
				pstmt.setString(3, id);
				
				return pstmt.executeUpdate();

			} catch (Exception e) {
			
				e.printStackTrace();
			
			}
			System.out.println("user_update db error");
			return -1; // 데이터베이스 오류
			
		}
		//삭제 메서드
		
		public int user_delete(String id) {

			String SQL = "delete FROM user_data where id = ?";

			try {

				PreparedStatement pstmt = conn.prepareStatement(SQL);   
			
				pstmt.setString(1, id);
			
				return pstmt.executeUpdate();
			


			} catch (Exception e) {

				e.printStackTrace();

			}
			System.out.println("user_delete db error");
			return -1; // 데이터베이스 오류

			}
		public int chk_pw_update(String id,String name) {
			String SQL = "SELECT name FROM user_data WHERE id = ?";

			try {

				// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
				pstmt = conn.prepareStatement(SQL);			
				// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
				pstmt.setString(1, id);
				// rs:result set 에 결과보관
				rs = pstmt.executeQuery();
				// 결과가 존재한다면 실행
				if (rs.next()) {
					// 패스워드 일치한다면 실행
					if (rs.getString(1).equals(name)) {
						return 1; // 로그인 성공
					} else
					{
						return 0; // 비밀번호 불일치
					}
				}			
				return -1; // 아이디가 없음 오류

			} catch (Exception e) {
				System.out.println("4444444444444444444");
				e.printStackTrace();
			}

			return -2; // 데이터베이스 오류를 의미
		}
		
		// 비밀번호 변경
				public int pw_update(String pw,String id) {
					String SQL = "UPDATE user_data SET pw = ? WHERE id = ?";

					try {

					pstmt = conn.prepareStatement(SQL);

					pstmt.setString(1, pw);

					pstmt.setString(2, id);

					return pstmt.executeUpdate();

					} catch (Exception e) {

					e.printStackTrace();

					}

					return -1; // DB 오류

					}
}
