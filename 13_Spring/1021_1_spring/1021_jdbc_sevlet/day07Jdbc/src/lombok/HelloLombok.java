package lombok;


// 특정 인스턴스 안의 여러 속성, 기능을 사용해서 DB의 행을 클래스처럼 사용할 수 있게 만든다. 
@Getter
@Setter
//@NoArgsConstructor
@RequiredArgsConstructor // final 필드 채우는 생성자
@AllArgsConstructor // 모든 필드 채울 때 생성자 
@ToString // 접근제어자와 상관 없이 모든 변수에 대해 결과를 String으로 출력합니다.
//@ToString(onlyExplicitlyIncluded=true)   // @ToString.Include 를 사용할 필드 바로 위에 명기해서 짝처럼 사용
public class HelloLombok {
	
	@ToString.Exclude // toString에서 제외할 필드 바로 위에 작성
	private final int num; // 명사
//	@ToString.Include
	final String name;
	
	String Hello;
	
//	public int getNum() {
//		return num;
//	}
//	public void setNum(int num) {
//		this.num = num;
//	}
//	public String getName() {
//		return name;
//	}
//	public void setName(String name) {
//		this.name = name;
//	}
//	public String getHello() {
//		return Hello;
//	}
//	public void setHello(String hello) {
//		Hello = hello;
//	}
//	
//	@Override
//	public String toString() {
//		return "HelloLombok [name=" + name + ", Hello=" + Hello + "]";
//	}
	

}
