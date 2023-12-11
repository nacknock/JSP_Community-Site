package board;

public class Board {
	private int b_idx;
	private int b_num;
	private int c_num;
	private int views;
	private String b_user_name;
	private String b_title;
	private String b_content;
	private String b_date;
	private int b_available;
	private String b_board;
	private String b_search;
	private String b_img;
	private String b_img_real;
	private int b_img_chk;
	
	public int getB_img_chk() {
		return b_img_chk;
	}
	public void setB_img_chk(int b_img_chk) {
		this.b_img_chk = b_img_chk;
	}
	public String getB_img_real() {
		return b_img_real;
	}
	public void setB_img_real(String b_img_real) {
		this.b_img_real = b_img_real;
	}
	public String getB_img() {
		return b_img;
	}
	public void setB_img(String b_img) {
		this.b_img = b_img;
	}
	public String getB_search() {
		return b_search;
	}
	public void setB_search(String b_search) {
		this.b_search = b_search;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getB_user_name() {
		return b_user_name;
	}
	public void setB_user_name(String b_user_name) {
		this.b_user_name = b_user_name;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public int getB_available() {
		return b_available;
	}
	public void setB_available(int b_available) {
		this.b_available = b_available;
	}
	public String getB_board() {
		return b_board;
	}
	public void setB_board(String b_board) {
		this.b_board = b_board;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
}
