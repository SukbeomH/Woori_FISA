package basic;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBUtil {
	// DB를 위한 드라이버를 메모리에 로딩 -> 클래스가 로드될 때 딱 한 번 메모리에 올라가 있으면 변경될 일이 없습니다.
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	// DB 접속
	public static Connection getConnection() throws SQLException {
	String url = "jdbc:mysql://118.67.131.22:3306/fisa?characterEncoding=UTF-8&serverTimezone=UTC";
	String id = "fisaai";
	String pw = "woorifisa3!W";
	
	// db 접속 객체
		return DriverManager.getConnection(url, id, pw);
		}
	
	
	// DB와 연결 해제(자원 반납) 
	public static void close(Connection conn, Statement stmt, ResultSet rs) throws SQLException {
		rs.close();
		stmt.close();
		conn.close();
	}
}
