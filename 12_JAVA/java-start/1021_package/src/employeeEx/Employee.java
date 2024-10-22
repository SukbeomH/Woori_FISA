package employeeEx;

public abstract class Employee {
    //	직원의 공통된 속성(name, workDays)과 기능(displayInfo(), getEmployeeCount())을 정의합니다.
    protected String name;
    protected int workDays;
    private static int employeeCount = 0;

    // 생성자
    public Employee(String name, int workDays) {
        this.name = name;
        this.workDays = workDays;
        employeeCount++; // 생성자가 1회 동작시마다 1씩 증가
    }

    public void displayInfo() {
        System.out.println("직원 이름: " + this.name);
        System.out.println("근무한 일수: "+ workDays);
    };

    // 직원이 현재까지 총 몇명 근무하고 있는지 확인하는 구상 메서드
    public static int getEmployeeCount() {
        return employeeCount; //employeeCount 클래스 변수는 private이지만 자기 클래스 안에서는 사용가능하므로
    };

    abstract double calculateSalary(); // calculateSalary()는 추상 메서드로 선언하여, 자식 클래스가 구체적인 구현을 제공합니다.
}
