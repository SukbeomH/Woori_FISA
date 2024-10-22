package basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class LoadDept {
	
	// localhost:3306 에 접속 root 0000 
	// fisa DB 안의 dept 테이블에 있는 행 삭제 / 행 추가 후 결과 확인
	public static void main(String[] args) {
		// *.Class 되어있는 바이트코드 파일을 메모리에 로딩 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/fisa?characterEncoding=UTF-8&serverTimezone=UTC";
			String id = "fisaai";
			String pw = "woorifisa3!W";
			
			// db 접속 객체
			Connection conn = DriverManager.getConnection(url, id, pw);

			// 문장 실행 객체
		
			Statement stmt = conn.createStatement();
			
			// executeUpdate - Read를 제외한 모든 sql 명령어를 실행 
			// 그 결과로 실제 영향을 끼친 row의 수를 리턴 
			String sql = "UPDATE dept SET dname='SALES' WHERE deptno=30";
			// 30번 deptno를 가진 2번 컬럼의 값을 'SALES로 변경
			int rs2 = stmt.executeUpdate(sql); 
			System.out.println(rs2);
			
			sql = "select * from dept";
			
			// 실제 Result를 가지고 있는 객체
			/* 1. 커서(포인터)를 이동시키는 기능 next()
			 * 2. 데이터를 리턴하는 기능 : getXxx(컬럼의 번호 or 컬럼 이름) 
			 * 				정수로 된 자료형의 컬럼 반환 : getInt(컬럼번호 or 컬럼명)
			 * 				문자열로 된 자료형 컬럼 반환 : getString(컬럼번호 or 컬럼명)  
			 */
			// executeQuery - Read를 실행
			// 그 결과로 SELECT된 전체 행을 가져 리턴
			ResultSet rs = stmt.executeQuery(sql); // Get, Set, 
			

			while (rs.next()) {
				System.out.println(rs.getInt("deptno")); // 컬럼명 
				System.out.println(rs.getString(2)); // 컬럼 순번 - sql은 1부터 순서가 시작
			}
			

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
