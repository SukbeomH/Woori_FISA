USE fisa;
SELECT * FROM box_office;

SELECT * FROM fisa.box_office;

SELECT 
    years, movie_name, sale_amt, rep_country
FROM
    fisa.box_office
WHERE
    years = 2019
        AND (sale_amt > 4000000000
        AND rep_country = '한국')
ORDER BY 2, sale_amt DESC
LIMIT 3;

-- # 연도별 개봉한 영화의 편수를 집계해서 출력해주세요
SELECT 
    YEAR(release_date), COUNT(movie_name)
FROM
    fisa.box_office
GROUP BY YEAR(release_date)
ORDER BY YEAR(release_date);

-- # 2019년 개봉 영화의 유형별 최대, 최소 매출액과 전체 매출액 집계하기
SELECT 
	 movie_type, MAX(sale_amt) AS 최대매출액, MIN(sale_amt) 최소매출액, SUM(sale_amt) "전체매출액"
FROM
    fisa.box_office
WHERE release_date LIKE '2019%' AND movie_type IS NOT NULL -- IS NULL, IS NOT NULL
GROUP BY movie_type
HAVING MAX(sale_amt) > 20000000
ORDER BY  MIN(sale_amt)
LIMIT 1;  -- GROUP BY로 묶은 결과를 바탕으로 특정 조건을 조회

SELECT 
	 movie_type, MAX(sale_amt) AS 최대매출액, MIN(sale_amt) 최소매출액, SUM(sale_amt) "전체매출액"
FROM
    fisa.box_office
WHERE release_date LIKE '2019%' AND movie_type IS NOT NULL -- IS NULL, IS NOT NULL
GROUP BY movie_type
HAVING MAX(sale_amt) > 20000000
ORDER BY  MIN(sale_amt)
LIMIT 1;  -- GROUP BY로 묶은 결과를 바탕으로 특정 조건을 조회


SELECT 
	 movie_type, MAX(sale_amt) AS 최대매출액, MIN(sale_amt) 최소매출액, SUM(sale_amt) "전체매출액"
FROM
    fisa.box_office
WHERE release_date LIKE '2019%' AND movie_type IS NOT NULL -- IS NULL, IS NOT NULL =, IN, LIKE로 찾을 수없음
GROUP BY movie_type
WITH ROLLUP;  -- 명시한 컬럼별로 GROUP BY한 결과를 전체 집계해주는 명령어

SELECT sale_amt
FROM fisa.box_office
WHERE sale_amt > 40000000000;

SELECT * FROM box_office;

SELECT movie_type, SUM(sale_amt)   -- 각 행에 대한 결과가 아니라 그룹으로 집계하고 싶은 결과 함수  
FROM  fisa.box_office
GROUP BY movie_type; -- 분류에 의한 결과 

SELECT movie_type, SUM(sale_amt)   -- 각 행에 대한 결과가 아니라 그룹으로 집계하고 싶은 결과 함수  
FROM  fisa.box_office
GROUP BY movie_type-- 분류에 의한 결과  
HAVING SUM(sale_amt)> 15000000000 -- GROUP BY로 나눈 뒤의 조건 
ORDER BY movie_type , SUM(sale_amt) DESC -- 순서 정렬 
LIMIT 2; 



-- SQL함수 : 진짜 많아요. 쓰시게 되는 것만 쓰게 될 거, 똑같은 동작을 하는 여러개 함수 
-- RDBMS 종류마다 쓰는 함수명을 다 넣어놓은 경우도 있습니다  
SELECT CHAR_LENGTH('SQL'), LENGTH('SQL'), CHAR_LENGTH('홍길동🤣'), LENGTH('홍길동🤣'); 
# SQL에서 한글 1글자 : 3바이트 LENGTH로 확인 

SELECT CONCAT('This', 'Is', 'MySQL', '.') AS CONCAT1, 
       CONCAT('SQL', NULL, 'Books') AS CONCAT2, # NULL과 문자열을 연결하면 그 결과는 NULL
       CONCAT_WS('/', 'This', 'Is', 'MySQL') AS CONCAT_WS; 
		# CONCAT_WS() 함수는 구분자인 첫 번째 매개변수가 콤마(,)이므로 두 번째부터 네 번째 매개변수를 연결하면서 그 사이에 구분자 콤마 기입

-- SQL은 언어가 거의 유사합니다. 회사마다 사용하는 서버의 종류도 다양합니다. 
-- 문법이나 함수명이 여러 서버에서 혼용할 수 있도록 
SELECT FORMAT(123456789.123656, 3) fmt, -- FORMAT(숫자를 3개씩 끊어서 ,로 출력, 소수점이후 N번째 자리까지 반올림 출력)
       FORMAT(123456789.123656, 0) fmt1,
       INSTR('ThisIsSQL', 'sql') instring, -- index string, MySQL은 1부터 시작, 윈도우서버 SQL은 대소문자 구분 없음 
       LOCATE('my', 'TheMyDBMSMySQL') locates, -- 'TheMyDBMSMySQL'에서 'my'를 찾아줘 5번째인덱스 이후에서 
       POSITION('my' IN 'TheMyDBMSMySQL') pos; -- LOCATE('my', 'TheMyDBMSMySQL', 1) 과 같은 동작
       
SELECT LOWER('ABcD'), LCASE('ABcD'),
       UPPER('abcD'), UCASE('abcD');
       
SELECT REPEAT(1234, 3),
       REPLACE('생일 축하해 철수야', '철수', '영희') REP,
       REVERSE(1234);

# SUBSTR() 함수는 첫 번째 매개변수 str의 문자열에서 두 번째 매개변수 pos로 지정된 위치부터 세 번째 매개변수 len만큼 잘라 반환합니다.
-- len은 생략 가능하며, 생략하면 str의 오른쪽 끝까지 잘라냅니다. 또한 pos 값에 음수도 넣을 수 있는데, 이때는 시작 위치를 왼쪽이 아닌 오른쪽 끝을 기준으로 잡습니다. 
-- 그리고 SUBSTRING(), MID() 함수는 SUBSTR() 함수와 사용법이 같습니다.
SELECT SUBSTR('This Is MySQL', 6) FIRST,
       SUBSTRING('This Is MySQL', 6, 2) SECOND,
       MID('This Is MySQL', -5) THIRD; -- 음수인덱싱

SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE,
       CURTIME(), CURRENT_TIME(), CURRENT_TIME,
       NOW(), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP;
       
SELECT DATE_FORMAT('2024-07-22 13:42:54', '%d-%b-%Y') Fmt1,
       DATE_FORMAT('2024-07-22 13:42:54', '%U %W %j') Fmt2;

SELECT STR_TO_DATE('21,07,2024', '%d,%m,%Y') CONV1,
       STR_TO_DATE('19:30:17', '%H:%i:%s') CONV2,
       STR_TO_DATE('09:30:17', '%h:%i:%s') CONV3,
       STR_TO_DATE('17:30:17', '%h:%i:%s') CONV4;  
       -- ‘19:30:17’에서 시간이 19시로 24시간 형태인데, 
       -- %h는 12시간 형태이므로 변환에 실패해 결국 NULL을 반환

SELECT SYSDATE(), SLEEP(2), SYSDATE(); -- 매번 함수 호출시의 시간

SELECT NOW(), SLEEP(2), NOW(); -- 문장 단위로 실행됨


 
SELECT DATE_ADD('2024-07-22', INTERVAL 5 DAY) DATEADD,
	   ADDDATE('2024-07-22', INTERVAL 5 MONTH) ADD_DATE1,
       ADDDATE('2024-07-22', 5 ) ADD_DATE2,
       ADDDATE('2024-07-22', INTERVAL '1 1' YEAR_MONTH) ADD_DATE3;
       
SELECT DATE_SUB('2024-07-22', INTERVAL 5 DAY) DATEADD,
	   SUBDATE('2024-07-22', INTERVAL 5 MONTH) ADD_DATE1,
       SUBDATE('2024-07-22', 5 ) ADD_DATE2,
       SUBDATE('2024-07-22', INTERVAL '1 1' YEAR_MONTH) ADD_DATE3;
       
-- EXTRACT() -- 매개변수의 date에서 특정 날짜 단위를 추출한 결과 반환
SELECT EXTRACT(YEAR_MONTH    FROM '2024-07-22 13:32:03') YEARMON,
       EXTRACT(DAY_HOUR      FROM '2024-07-22 13:32:03') DAYHOUR,
       EXTRACT(MINUTE_SECOND FROM '2024-07-22 13:32:03') MINSEC;

-- int('10') type casting 
SELECT CAST(10 AS CHAR)                 CONV_CHAR,
       CAST('-10' AS SIGNED)           CONV_INT, -- 양수, 음수 다 받는 자료형 
       CAST('10.2131' AS DECIMAL)       CONV_DEC1, -- (최대자리, 소수점이하n자리)
       CAST('10.2131' AS DECIMAL(6, 2)) CONV_DEC2, -- 고정소수점
       CAST('10.2131' AS DOUBLE)        CONV_DOUBLE, -- 부동소수점 -> 앞으로는 뺄거래요 
       CAST('2021-10-31' AS DATE)       CONV_DATE,
       CAST('2021-10-31' AS DATETIME)   CONV_DATETIME;
DESCRIBE fisa.box_office;
/*  CONVERT() 함수도 CAST() 함수와 마찬가지로 형 변환하나,
 CAST() 함수와 달리 AS type 대신 type을 두 번째 매개변수로 받음 */
SELECT CONVERT(10, CHAR)                 CONV_CHAR,
       CONVERT('-10', SIGNED)            CONV_INT,
       CONVERT('10.2131', DECIMAL)       CONV_DEC1,
       CONVERT('10.2131', DECIMAL(6, 4)) CONV_DEC2,
       CONVERT('10.2131', DOUBLE)        CONV_DOUBLE,
       CONVERT('2021-10-31', DATE)       CONV_DATE,
       CONVERT('2021-10-31', DATETIME)   CONV_DATETIME;
       
 
 -- 흐름제어 함수
# 흐름 제어(flow control) 함수란 특정 조건을 확인해 조건에 부합하는 경우와 그렇지 않은 경우에 다른 값을 반환하는 함수
# 흐름 제어 함수에는 IF(), IFNULL(), NULLIF() 함수가 있고, 흐름 제어 함수와 비슷한 역할을 하는 CASE 연산자도 있다
SELECT IF(2 < 1, 1, 0) IF1,  -- IF(조건, 참일때 리턴값, 거짓일 때 리턴값)
       IF('A' = 'a', 'SAME', 'NOT SAME') IF2, -- window의 MYSQL에서는 대소문자 구분 X 
       IF(1 = 2, 1, 'A') IF3;

-- NULLIF() 함수는 두 매개변수 expr1과 expr2 값이 같으면 NULL을, 같지 않으면 expr1을 반환
SELECT NULLIF(1, 1) NULLIF1,
       NULLIF(1, 0) NULLIF2,
       NULLIF(NULL, NULL) NULLIF3;

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

SELECT STR_TO_DATE('2024-04-21', '%Y-%m-%d') CONV1; -- 'YYYY-MM-DD'

SELECT CAST('조건' AS UNSIGNED); # 0 으로 형변환 
SELECT CAST(FALSE AS UNSIGNED);

SELECT CASE '조건' WHEN 0 THEN 'A' -- CASE 값 WHEN 첫번째 명제 THEN 첫번째 명제가 참일 경우 출력할 값
                  WHEN 1 THEN 'B' --         WHEN 두번째 명제 THEN 두번째 명제가 참일 경우 출력할 값
       END CASE1;
       
-- MYSQL도 0과 FALSE, 1과 TRUE가 내부적으로는 같은 값을 가지는 구나
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
       
USE fisa;
-- DATABASE()와 SCHEMA() 함수는 현재 접속해 있는 데이터베이스 이름을, USER() 함수는 현재 로그인한 사용자 이름을 반환       
SELECT DATABASE(), SCHEMA(), USER(); -- MYSQL에서는 DATABASE(), SCHEMA()가 동일합니다 

-- 실습.
# 1. box_office 테이블에서 2015년 이후 개봉한 영화 중 연도별로 2번 이상 
# 관객수 100만을 넘긴 영화의 감독과 해당 관객의 영화를 본 관객수를 
# 연도별, 감독별로 구하는 쿼리를 작성하세요.
SELECT YEAR(release_date), director, SUM(audience_num) 
FROM fisa.box_office
WHERE YEAR(release_date) >= 2015 AND audience_num >= 1000000
GROUP BY YEAR(release_date), director;

SELECT YEAR(release_date), director, SUM(audience_num) 
FROM fisa.box_office
WHERE YEAR(release_date) >= 2015 AND audience_num >= 1000000
GROUP BY YEAR(release_date), director
HAVING COUNT(director)
ORDER BY 3 DESC
LIMIT 10;

# 2. 2019년 1분기(QUARTER 함수 사용) 개봉 영화 중 
# 매출액이 천만 원 이상인 영화의 
# 월별, 영화 유형별 매출액 소계를 구하는 쿼리
SELECT QUARTER(release_date) FROM fisa.box_office;

SELECT 
    MONTH(release_date), SUM(sale_amt), movie_type
FROM
    fisa.box_office
WHERE
	YEAR(release_date) = 2019
    AND QUARTER(release_date) = 1
GROUP BY MONTH(release_date) , movie_type 
WITH ROLLUP;


SELECT MONTH(release_date), IF(GROUPING(movie_type) = 1, '소계', movie_type) 영화유형, SUM(sale_amt)
FROM fisa.box_office
WHERE YEAR(release_date) = 2019 AND QUARTER(release_date) = 1
GROUP BY MONTH(release_date), movie_type WITH ROLLUP;


/* 3. 2019년 개봉 영화 중 매출액이 천만 원 이상인 영화의 월별(MONTH), 영화 유형별 매출액 소계를 구하되
	7월 1일 전에 개봉한 영화이면 상반기,
	7월 1일 이후에 개봉한 영화이면 하반기라고 함께 출력하는 쿼리 */
SELECT MONTH(release_date) 월별, movie_type 영화유형, SUM(sale_amt) 총계, IF(MONTH(release_date) > 6, '하반기', '상반기')
FROM box_office
WHERE YEAR(release_date) = 2019 
 AND sale_amt >= 10000000
GROUP BY MONTH(release_date), movie_type, IF(MONTH(release_date) > 6, '하반기', '상반기')
ORDER BY 1;

-- 4. 부제가 있는 영화 찾기 ':' 2015년 이후의 개봉영화 중에서 부제가 달려있는 영화의 개수 세어보기 
SELECT  YEAR(release_date), COUNT(*)
FROM fisa.box_office
WHERE YEAR(release_date) >= 2015 AND movie_name LIKE "%:%"
GROUP BY YEAR(release_date)
ORDER BY 1;

SELECT year(release_date), COUNT(movie_name) 전체개봉편수, 
SUM(IF(movie_name LIKE '%:%', 1, 0)) 부제있는편수,  
ROUND(SUM(IF(movie_name LIKE '%:%', 1, 0))/COUNT(movie_name)*100, 2) "전체영화 중 부제있는 영화 비율" -- 총 영화의 개수로 한번 나눠서 비율을 봐야 
FROM box_office
WHERE year(release_date) >= 2015 -- _ 는 딱 한개
GROUP BY  year(release_date)
ORDER BY 1;

/*  5. 감독이 두 명 이상이면 콤마(,)로 이어져 있습니다(예, ‘홍길동,김감독’). 감독이 1명이면 그대로, 
   두 명 이상이면 콤마 대신 ‘/’ 값으로 대체해(예, ‘홍길동/김감독’) 출력하는 쿼리를 작성해 보세요. */
SELECT REPLACE(director, ',', '/') FROM fisa.box_office;
