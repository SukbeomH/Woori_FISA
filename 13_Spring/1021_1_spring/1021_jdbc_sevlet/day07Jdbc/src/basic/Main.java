package basic;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Main {

	public static void main(String[] args) {
		
		ArrayList<Dept> deptList = new ArrayList<>(); // 행의 개수에 따라 얼마든지 가변적으로 데이터를 삽입할 수 있는 ArrayList 
		String sql = "SELECT deptno, dname, loc FROM dept";
		
		Connection conn;
		try {
			conn = DBUtil.getConnection();
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		

		while (rs.next()) {
			int deptno = rs.getInt("deptno"); // 컬럼명
			String dname = rs.getString("dname"); // 컬럼 순번 - sql은 1부터 순서가 시작
			String loc = rs.getString("loc");
			
			Dept dept = new Dept(deptno, dname, loc);
			deptList.add(dept);
			}
		
		DBUtil.close(conn, stmt, rs); // 자원을 한꺼번에 close() 
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println(deptList.toString());
		
		
		
	

	}

}
