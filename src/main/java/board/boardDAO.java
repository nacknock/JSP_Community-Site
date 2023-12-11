package board;

import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;



public class boardDAO {

// dao : 데이터베이스 접근 객체의 약자

private Connection conn; // connection:db에접근하게 해주는 객체

//private PreparedStatement pstmt;

private ResultSet rs;



// mysql 처리부분

public boardDAO() {

// 생성자를 만들어준다.

	try {
	
		String dbURL = "jdbc:mysql://localhost:3306/jsp_solo?&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		
		String dbID = "root";
		
		String dbPassword = "qwer";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}

}

//현재의 시간을 가져오는 함수

public String getDate() { 

	String SQL = "SELECT NOW()";

	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getString(1);
	
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return ""; //데이터베이스 오류

}

//bbsID 게시글 번호 가져오는 함수

public int getNext(String board) { 

	String SQL = "SELECT b_num FROM board_data WHERE board = ? and Available = 1 ORDER BY idx DESC";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getInt(1) + 1;
		
		}
		
		return 1;//첫 번째 게시물인 경우
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류

}

//실제로 글을 작성하는 함수

public int write(String title, String nickname, String content, String board) { 

	String SQL = "INSERT INTO board_data (b_num,user_name,title,content,date,Available,board,c_num,views,img_bool)"
			+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, getNext(board));
		
		pstmt.setString(2, nickname);
		
		pstmt.setString(3, title);
		
		pstmt.setString(4, content);
		
		pstmt.setString(5, getDate());
		
		pstmt.setInt(6,1);
		
		pstmt.setString(7, board);
		
		pstmt.setInt(8,0);

		pstmt.setInt(9,0);
		
		pstmt.setInt(10,0);
		
		return pstmt.executeUpdate();
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류

}

//실제로 글을 작성하는 함수

public int write_img(String title, String nickname, String content, String board, String file, String fileReal) { 

	String SQL = "INSERT INTO board_data (b_num,user_name,title,content,date,Available,board,c_num,views,filename,filerealname,img_bool)"
			+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, getNext(board));
		
		pstmt.setString(2, nickname);
		
		pstmt.setString(3, title);
		
		pstmt.setString(4, content);
		
		pstmt.setString(5, getDate());
		
		pstmt.setInt(6,1);
		
		pstmt.setString(7, board);
		
		pstmt.setInt(8,0);

		pstmt.setInt(9,0);
		
		pstmt.setString(10, file);

		pstmt.setString(11, fileReal);
		
		pstmt.setInt(12,1);
		
		return pstmt.executeUpdate();
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류

}

//댓글 번호 가져오는 함수

public int getNext_comm(String board,int b_num) { 

	String SQL = "SELECT c_num FROM board_data WHERE board = ? and b_num = ? and not c_num = 0 ORDER BY idx DESC";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		pstmt.setInt(2, b_num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getInt(1) + 1;
		
		}
		
		return 1;//첫 번째 댓글인 경우
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류

}

//실제로 댓글을 작성하는 함수

public int write_comm(int b_num, String nickname, String content, String board) { 

	String SQL = "INSERT INTO board_data (b_num,c_num,user_name,content,date,Available,board,views) VALUES(?, ?, ?, ?, ?, ?, ?, 0)";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, b_num);
		
		pstmt.setInt(2, getNext_comm(board,b_num));
		
		pstmt.setString(3, nickname);
		
		pstmt.setString(4, content);
		
		pstmt.setString(5, getDate());
		
		pstmt.setInt(6,2);
		
		pstmt.setString(7, board);
		
		return pstmt.executeUpdate();
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류

}

//10 단위 페이징 처리를 위한 함수

public boolean nextPage (int pageNumber,String board) {
String SQL = "SELECT * FROM board_data WHERE b_num < ? and board = ? and Available = 1 ORDER BY b_num DESC LIMIT 10";
ArrayList<Board> list = new ArrayList<Board>();
try {
	PreparedStatement pstmt = conn.prepareStatement(SQL);
	pstmt.setInt(1, getNext(board) - (pageNumber -1) * 10);
	pstmt.setString(2, board);
	rs = pstmt.executeQuery();
	if (rs.next()) {
		return true;
	}
} catch (Exception e) {
	e.printStackTrace();
}

return false;

}

//게시판 페이지 목록 함수

public ArrayList<Board> getList(int pageNumber,String board){ 

	String SQL = "SELECT * FROM board_data WHERE b_num < ? and board = ? and Available = 1 ORDER BY b_num DESC LIMIT 10";
	
	ArrayList<Board> list = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, getNext(board) - (pageNumber -1) * 10);
		
		pstmt.setString(2, board);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_title(rs.getString(3));
			
			Board.setB_content(rs.getString(4));
			
			Board.setB_date(rs.getString(5));
			
			Board.setB_available(rs.getInt(6));
			
			Board.setViews(rs.getInt(10));
			
			list.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list; 
	
	}

///메인페이지 게시판들///

//강아지 게시판

public ArrayList<Board> getList2(String board){ 

	String SQL = "SELECT * FROM board_data WHERE board = ? and Available = 1 ORDER BY b_num DESC LIMIT 10";
	
	ArrayList<Board> list2 = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_title(rs.getString(3));
			
			Board.setB_date(rs.getString(5));
			
			list2.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list2; 
	
	}

//고양이 게시판

public ArrayList<Board> getList3(String board){ 

	String SQL = "SELECT * FROM board_data WHERE board = ? and Available = 1 ORDER BY b_num DESC LIMIT 10";
	
	ArrayList<Board> list3 = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_title(rs.getString(3));
			
			Board.setB_date(rs.getString(5));
			
			list3.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list3; 
	
	}

//그 외 게시판

public ArrayList<Board> getList4(String board){ 

	String SQL = "SELECT * FROM board_data WHERE board = ? and Available = 1 ORDER BY b_num DESC LIMIT 10";
	
	ArrayList<Board> list4 = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_title(rs.getString(3));
			
			Board.setB_date(rs.getString(5));
			
			list4.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list4; 
	
	}

///view에서 띄울것

public Board getBoard(int b_num,String animal) {

	String SQL = "SELECT * FROM board_data WHERE b_num = ? AND board = ? AND Available = 1";
	
	try {
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, b_num);
		
		pstmt.setString(2, animal);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
		
			Board board = new Board();
			
			board.setB_num(rs.getInt(8));
			
			board.setB_title(rs.getString(3));
			
			board.setB_user_name(rs.getString(2));
			
			board.setB_date(rs.getString(5));
			
			board.setB_content(rs.getString(4));
			
			board.setB_available(rs.getInt(6));

			board.setViews(rs.getInt(10));
			
			board.setB_img(rs.getString(11));
			
			board.setB_img_real(rs.getString(12));
			
			board.setB_img_chk(rs.getInt(13));
			
			return board;
			
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	System.out.println("getBoard db error");
	return null;
	
	}

//수정 메서드

public int update(int b_num,String animal, String b_title, String b_content) {

	String SQL = "UPDATE board_data SET title = ?, content = ? WHERE b_num = ? AND board = ? AND c_num = 0";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, b_title);
		
		pstmt.setString(2, b_content);
		
		pstmt.setInt(3, b_num);
		
		pstmt.setString(4, animal);
		
		return pstmt.executeUpdate();

	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	System.out.println("update db error");
	return -1; // 데이터베이스 오류
	
}

//삭제 메서드
	
public int delete(int b_num,String animal) {

	String SQL = "UPDATE board_data SET Available = 0 WHERE b_num = ? AND board = ? AND c_num = 0";

	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);   
	
		pstmt.setInt(1, b_num);
		
		pstmt.setString(2, animal);
	
		return pstmt.executeUpdate();
	


	} catch (Exception e) {

		e.printStackTrace();

	}
	System.out.println("delete db error");
	return -1; // 데이터베이스 오류

	}

//댓글 view에 띄우기
	
public ArrayList<Board> getList_comm(String board,int b_num){ 

	String SQL = "SELECT * FROM board_data WHERE board = ? and b_num = ? and Available = 2 ORDER BY c_num LIMIT 10";
	
	ArrayList<Board> list_comm = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		pstmt.setInt(2, b_num);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setC_num(rs.getInt(9));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_content(rs.getString(4));
			
			Board.setB_date(rs.getString(5));
			
			list_comm.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list_comm; 
	
	}
	
///댓글 업데이트시 확인 절차용
	
public Board getBoard_comm(int b_num,int c_num,String animal) {

	String SQL = "SELECT * FROM board_data WHERE b_num = ? AND c_num = ? AND board = ? AND Available = 2";
	
	try {
		System.out.println("b_num=="+b_num);
		
		System.out.println("c_num=="+c_num);
		
		System.out.println("animal=="+animal);
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, b_num);
		
		pstmt.setInt(2, c_num);
		
		pstmt.setString(3, animal);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
		
			Board board = new Board();
			
			board.setB_num(rs.getInt(8));

			board.setC_num(rs.getInt(9));
			
			board.setB_user_name(rs.getString(2));
			
			board.setB_date(rs.getString(5));
			
			board.setB_content(rs.getString(4));
			
			board.setB_available(rs.getInt(6));
			
			
			
			return board;
			
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	System.out.println("getBoard_c db error");
	return null;
	
	}
	
//댓글 수정 메서드

public int update_comm(int b_num, int c_num, String animal, String b_content) {

	String SQL = "UPDATE board_data SET content = ? WHERE b_num = ? AND c_num = ? AND board = ?";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);

		pstmt.setString(1, b_content);
		
		pstmt.setInt(2, b_num);
		
		pstmt.setInt(3, c_num);
		
		pstmt.setString(4, animal);
		
		return pstmt.executeUpdate();

	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	System.out.println("update_c db error");
	return -1; // 데이터베이스 오류
	
}
		
//댓글 삭제 메서드
		
public int delete_comm(int b_num,int c_num,String animal) {

	String SQL = "UPDATE board_data SET Available = 0 WHERE b_num = ? AND c_num = ? AND board = ?";

	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);   
	
		pstmt.setInt(1, b_num);
	
		pstmt.setInt(2, c_num);
		
		pstmt.setString(3, animal);
	
		return pstmt.executeUpdate();
	


	} catch (Exception e) {

		e.printStackTrace();

	}
	System.out.println("delete_c db error");
	return -1; // 데이터베이스 오류

	}
		
//조회수 불러오는 메서드
		
public int views_sel(int b_num,String animal) {
	
	String SQL = "SELECT views FROM board_data WHERE b_num = ? AND board = ? AND Available = 1";
	
	try {
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, b_num);
		
		pstmt.setString(2, animal);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getInt(1);
		
		}
		
	}catch (Exception e) {

		e.printStackTrace();

	}
	System.out.println("views_select db error");
	return -1; // 데이터베이스 오류
}

//조회수 올리는 메서드

public int views_up(int b_num,int views,String animal) {
	
	String SQL = "UPDATE board_data SET views = ? WHERE b_num = ? AND board = ? AND Available = 1";
	
	try {
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1, views+1);

		pstmt.setInt(2, b_num);
		
		pstmt.setString(3, animal);
		
		return pstmt.executeUpdate();
		
	}catch (Exception e) {

		e.printStackTrace();

		}
		System.out.println("views_up db error");
		return -1; // 데이터베이스 오류
}

//검색 메서드

public ArrayList<Board> getList_search(int pageNumber, String search, String box){ 
	
	if(box.equals("content")) {
	
	String SQL = "SELECT * FROM board_data WHERE idx < ? and Available = 1 and content like ? ORDER BY date DESC LIMIT 10";
	
	ArrayList<Board> list_search = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setInt(1,  getNext_search(search,box) - (pageNumber -1) * 10);
		
		pstmt.setString(2, "%"+search.trim()+"%");
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_num(rs.getInt(8));
			
			Board.setB_user_name(rs.getString(2));
			
			Board.setB_board(rs.getString(7));

			Board.setB_title(rs.getString(3));
			
			Board.setB_content(rs.getString(4));
			
			Board.setB_date(rs.getString(5));
			
			Board.setViews(rs.getInt(10));
			
			list_search.add(Board);
		
		}
	
	} catch (Exception e) {
		System.out.println("getList_search error");
		e.printStackTrace();
	
		}
	
	return list_search;
	}
	if(box.equals("title")) {
		
		String SQL = "SELECT * FROM board_data WHERE idx < ? and Available = 1 and title like ? ORDER BY date DESC LIMIT 10";
		
		ArrayList<Board> list_search = new ArrayList<Board>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,  getNext_search(search,box) - (pageNumber -1) * 10);
			
			pstmt.setString(2, "%"+search.trim()+"%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				Board Board = new Board();
				
				Board.setB_num(rs.getInt(8));
				
				Board.setB_user_name(rs.getString(2));
				
				Board.setB_board(rs.getString(7));
				
				Board.setB_title(rs.getString(3));
				
				Board.setB_content(rs.getString(4));
				
				Board.setB_date(rs.getString(5));
				
				Board.setViews(rs.getInt(10));
				
				list_search.add(Board);
				
			}
			
		} catch (Exception e) {
			System.out.println("getList_search error");
			e.printStackTrace();
			
		}
		
		return list_search;
	}
	if(box.equals("user_name")) {
		
		String SQL = "SELECT * FROM board_data WHERE idx < ? and Available = 1 and user_name like ? ORDER BY date DESC LIMIT 10";
		
		ArrayList<Board> list_search = new ArrayList<Board>();
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,  getNext_search(search,box) - (pageNumber -1) * 10);
			
			pstmt.setString(2, "%"+search.trim()+"%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				Board Board = new Board();
				
				Board.setB_num(rs.getInt(8));
				
				Board.setB_user_name(rs.getString(2));
				
				Board.setB_board(rs.getString(7));
				
				Board.setB_title(rs.getString(3));
				
				Board.setB_content(rs.getString(4));
				
				Board.setB_date(rs.getString(5));
				
				Board.setViews(rs.getInt(10));
				
				list_search.add(Board);
				
			}
			
		} catch (Exception e) {
			System.out.println("getList_search error");
			e.printStackTrace();
			
		}
		
		return list_search;
	}
		System.out.println("getList_search null error");
		return null;
	}

//10 단위 페이징 처리를 위한 함수

public boolean nextPage_S (int pageNumber,String search,String box) {
String SQL = "SELECT * FROM board_data WHERE idx < ? and Available = 1 ORDER BY date DESC LIMIT 10";
ArrayList<Board> list_search = new ArrayList<Board>();
try {
	PreparedStatement pstmt = conn.prepareStatement(SQL);
	pstmt.setInt(1, getNext_search(search,box) - (pageNumber -1) * 10);
	rs = pstmt.executeQuery();
	if (rs.next()) {
		return true;
	}
} catch (Exception e) {
	System.out.println("nextPage_S error");
	e.printStackTrace();
}

return false;

}

//bbsID 검색결과 번호 가져오는 함수

public int getNext_search(String search,String box) { 
	
	if(box.equals("title")) {
	String SQL = "SELECT idx FROM board_data WHERE Available = 1 and title like ? ORDER BY idx DESC";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);

		pstmt.setString(1, "%"+search.trim()+"%");
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getInt(1) + 1;
		
		}
		
		return 1;//첫 번째 게시물인 경우
	
	} catch (Exception e) {
		System.out.println("getNext_search db title error");
		e.printStackTrace();
	
	}
	}
	if(box.equals("user_name")) {
		String SQL = "SELECT idx FROM board_data WHERE Available = 1 and user_name like ? ORDER BY idx DESC";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, "%"+search.trim()+"%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				return rs.getInt(1) + 1;
				
			}
			
			return 1;//첫 번째 게시물인 경우
			
		} catch (Exception e) {
			System.out.println("getNext_search db user_name error");
			e.printStackTrace();
			
		}
	}
	if(box.equals("content")) {
		String SQL = "SELECT idx FROM board_data WHERE Available = 1 and content like ? ORDER BY idx DESC";
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, "%"+search.trim()+"%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				return rs.getInt(1) + 1;
				
			}
			
			return 1;//첫 번째 게시물인 경우
			
		} catch (Exception e) {
			System.out.println("getNext_search db content error");
			e.printStackTrace();
			
		}
	}
	System.out.println("getNext_search db none if error");
	return -1; //데이터베이스 오류

}

//내가 쓴글

public ArrayList<Board> getList_user_b(String user_name){ 

	String SQL = "SELECT * FROM board_data WHERE user_name = ? and Available = 1 ORDER BY date DESC LIMIT 10";
	
	ArrayList<Board> list_user_b = new ArrayList<Board>();
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, user_name);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
		
			Board Board = new Board();
			
			Board.setB_title(rs.getString(3));
			
			Board.setB_board(rs.getString(7));
			
			Board.setB_num(rs.getInt(8));
			
			list_user_b.add(Board);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return list_user_b; 
	
	}

//내가 쓴 댓글

public ArrayList<Board> getList_user_c(String user_name){ 
	
	String SQL = "SELECT * FROM board_data WHERE user_name = ? and Available = 2 ORDER BY date DESC LIMIT 10";
	
	ArrayList<Board> list_user_c = new ArrayList<Board>();
	
	try {
		
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, user_name);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			
			Board Board = new Board();
			
			Board.setB_content(rs.getString(4));
			
			Board.setB_board(rs.getString(7));
			
			Board.setB_num(rs.getInt(8));
			
			list_user_c.add(Board);
			
		}
		
	} catch (Exception e) {
		
		e.printStackTrace();
		
	}
	
	return list_user_c; 
	
}


// view 이미지 여부 체크

public int img_chk(String board,int b_num) {
	
String SQL = "SELECT img_bool FROM board_data WHERE board = ? and b_num = ?";
	
	try {
	
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		
		pstmt.setString(1, board);
		
		pstmt.setInt(2, b_num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
			return rs.getInt(1);
		
		}
	
	} catch (Exception e) {
	
		e.printStackTrace();
	
	}
	
	return -1; //데이터베이스 오류
	
}
}
