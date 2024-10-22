package employeeEx;

public class ContractEmployee extends Employee {

    private double dailyRate;  // 일당

    public ContractEmployee(String name, int workDays, double dailyRate) {
        super(name, workDays);
        this.dailyRate = dailyRate;
    }

    @Override
    double calculateSalary() {
        return workDays*dailyRate;
    }

}