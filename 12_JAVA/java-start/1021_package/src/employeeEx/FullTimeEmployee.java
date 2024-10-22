package employeeEx;

// Employee 클래스를 상속받고, BonusEligible 인터페이스를 구현하는 정직원 관리 클래스
public class FullTimeEmployee extends Employee implements BonusEligible{

    private double monthlySalary;

    public FullTimeEmployee(String name, int workDays, double monthlySalary) {
        super(name, workDays);
        this.monthlySalary = monthlySalary;
    }

    @Override // 인터페이스에서 온 추상 메서드
    public double calculateBonus() {
        // 보너스 계산 메서드 - 월급의 10%를 계산해서 추가
        return monthlySalary * 0.1;
    }

    @Override // 추상클래스에서 온 추상 메서드
    double calculateSalary() {
        return monthlySalary;
    }

}