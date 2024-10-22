package lombok;


// 특정 인스턴스 안의 여러 속성, 기능을 사용해서 DB의 행을 클래스처럼 사용할 수 있게 만든다. 
@AllArgsConstructor
@Data // Getter, Setter, toString, equals, hashCode 어노테이션을 한번에 표기하도록 하는 
// @Data 롬복 어노테이션의 기본 생성자는 @RequiredArgsConstructor이다. 그러나 우리가 조합을 바꾸면 변경 가능 
public class HelloLombok2 {
	
	@ToString.Exclude // toString에서 제외할 필드 바로 위에 작성
	private final int num; // 명사
	final String name;
	
	String Hello;
	
}
