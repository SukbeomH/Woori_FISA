package employeeEx;

// 기준이 추상 메서드들 그리고 final 변수처럼 더는 바뀌지 않을 것들을 물려주고 확인하기 위한 점검표
public interface BonusEligible {
    double calculateBonus();  // 보너스 계산 메서드 - 월급의 10%를 계산해서 추가
}
