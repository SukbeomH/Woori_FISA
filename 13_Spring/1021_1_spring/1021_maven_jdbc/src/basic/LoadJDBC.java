package basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class LoadJDBC {

	public static void main(String[] args) {
		// *.Class 되어있는 바이트코드 파일을 메모리에 로딩 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
//			String url = ":://:/?=UTF-8&=UTC";
//			String id = "";
//			String pw = "!W";
			
			// DB 접속 객체
			Connection conn = DriverManager.getConnection(url, id, pw);
			
			// 문장 실행 객체
			Statement stmt = conn.createStatement();
			String sql = "select * from dept";
			
			// 실제 Result 가지고 있는 객체
			/* 1. 커서(포인터)를 이동시키는 기능 next()
			 * 2. 데이터를 리턴하는 기능 : getXxx(컬럼의 번호 or 컬럼 이름) 
			 * 				정수로 된 자료형의 컬럼 반환 : getInt(컬럼번호 or 컬럼명)
			 * 				문자열로 된 자료형 컬럼 반환 : getString(컬럼번호 or 컬럼명)  
			 */
			ResultSet rs = stmt.executeQuery(sql); // Get, Set, 
			
			while (rs.next()) {
				System.out.println(rs.getInt("deptno")); // 컬럼명 
				System.out.println(rs.getString(2)); // 컬럼 순번 - sql은 1부터 순서가 시작
			}
			// 콘솔창에 출력 결과를 직접 확인해주세요.
			
			// 자원 반납
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

}
