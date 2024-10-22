package employeeEx;

public class Main {

    public static void main(String[] args) {
        // 클래스 메서드라 객체 생성 없이 사용이 가능합니다. static
        System.out.println(Employee.getEmployeeCount());

        FullTimeEmployee lee = new FullTimeEmployee("이성진", 20, 100);
        lee.displayInfo();

        ContractEmployee shin = new ContractEmployee("신형만", 30, 3);
        shin.displayInfo();

        System.out.println(lee.calculateSalary());
        System.out.println(lee.calculateBonus());  // 보너스 계산 메서드는 FullTimeEmployee에서만 사용 가능
        System.out.println(shin.calculateSalary());

    }

}