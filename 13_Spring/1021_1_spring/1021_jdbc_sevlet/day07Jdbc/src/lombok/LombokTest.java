package lombok;

public class LombokTest {

	public static void main(String[] args) {
		
//		HelloLombok hello1 = new HelloLombok();
		HelloLombok hello2 = new HelloLombok(3, "김연지", "헬로3");
//		HelloLombok hello3 = new HelloLombok(3, "김연지");
		System.out.println(hello2.toString()); // lombok.HelloLombok@48cf768c 
		
		HelloLombok2 hello4 = new HelloLombok2(1, "김연지HL2", "헬로4");
		System.out.println(hello4.toString()); 
		
//		hello1.setHello("헬로1");
//		System.out.println(hello1.getHello());

	}

}
