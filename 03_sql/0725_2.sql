SELECT STR_TO_DATE('21,07,2024', '%d,%m,%Y') CONV1;

SELECT CAST('조건' AS UNSIGNED);
SELECT CAST(FALSE AS UNSIGNED);

SELECT CASE '조건' WHEN 0 THEN 'A' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
                  WHEN 1 THEN 'B' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1;
       
SELECT CASE 0 WHEN FALSE THEN 'A' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
                  WHEN TRUE THEN 'B' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1;

SELECT CASE 'A' WHEN 'A' THEN 'A임' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
                  WHEN 'B' THEN 'B임' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1;
       
SELECT CASE '1' WHEN 0 THEN 'A' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
                  WHEN 1 THEN 'B' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1,             --         ELSE 앞의 모든 명제가 거짓인 경우 출력할 값 
							  -- END 해당 조건을 부르기 위한 ALIAS
       CASE 9 WHEN 0 THEN 'A'
              WHEN 1 THEN 'B'
              ELSE 'None'
       END CASE2,
       CASE WHEN 25 BETWEEN 1 AND 19 THEN '10대' -- 범위 지정도 가능합니다
            WHEN 25 BETWEEN 20 AND 29 THEN '20대'
            WHEN 25 BETWEEN 30 AND 39 THEN '30대'
            ELSE '30대 이상'
       END CASE3;