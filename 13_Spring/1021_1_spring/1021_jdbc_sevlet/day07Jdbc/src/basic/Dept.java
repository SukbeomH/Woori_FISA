package basic;

import lombok.AllArgsConstructor;
import lombok.Data;

// 테이블명과 같은 이름으로 작성합니다. 다만 클래스이므로 맨 앞글자는 대문자
@AllArgsConstructor
@Data
public class Dept {
	
	public int deptno;
	public String dname;
	public String loc;
	
}
