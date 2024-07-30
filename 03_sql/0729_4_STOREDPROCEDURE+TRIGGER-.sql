/* 
1. 스토어드 프로시저(Stored Procedure)
- SQL에서 프로그래밍이 가능해 주는 서버의 기능
- 자주 사용하는 여러개의 SQL문을 한데 묶어 함수처럼 만들어 일괄적으로 처리하는 용도로 사용됩니다.
- 첫 행과 마지막 행에 구분문자라는 의미의 DELIMITER ~ DELIMITER 문으로 감싼 후 사이에 BEGIN과 END 사이에 SQL문을 넣습니다.
- DELIMITER에는 $$ // && @@ 등의 부호를 구분문자로 많이 사용합니다.
- 위와 같이 작성해놓으면 CALL 프로시저명(); 으로 위의 SQL 묶음을 호출할 수 있습니다.

- 장점
    - 하나의 요청으로 여러 SQL문을 실행 할 수 있습니다.
    - 독립적으로 실행됩니다. SELECT 문이나 다른 SQL 문에서 직접 사용할 수 없습니다.
    - 데이터베이스 상태를 변경할 수 있습니다. INSERT, UPDATE, DELETE 문을 사용할 수 있습니다.
    - 네트워크 소요 시간을 줄일 수 있습니다.
        - 긴 여러개의 쿼리를 SP를 이용해서 구현한다면 SP를 호출할 때
          한 번만 네트워크를 경유하기 때문에 네트워크 소요시간을 줄이고 성능을 개선할 수 있습니다.
    - 개발 업무를 구분해 개발 할 수 있습니다.
        - 순수한 애플리케이션만 개발하는 조직과 DBMS 관련 코드를 개발하는 조직이 따로 있다면,
          DBMS 개발하는 조직에서는 데이터베이스 관련 처리하는 SP를 만들어 API처럼 제공하고 
          애플리케이션 개발자는 SP를 호출해서 사용하는 형식으로 역할을 구분한 개발이 가능합니다.
          
          SHOW PROCEDURE STATUS; -- 프로시저 목록 확인
		  SHOW CREATE PROCEDURE film_not_in_stock; -- 프로시저 내용 확인
		  DROP PROCEDURE 프로시저이름; -- 프로시저 삭제
		  CALL 프로시저이름(변수1, 변수2, 변수3);
*/
SHOW PROCEDURE STATUS; 
SHOW CREATE PROCEDURE sakila.film_not_in_stock;

-- OUT 매개변수를 저장할 변수를 선언합니다.
SET @count = 0;

-- 저장 프로시저를 호출합니다.
USE sakila;
-- 2번 film의 비디오테입이 2번 store에 몇개 남아있는지 결과를 @count 에 담아줘
CALL film_not_in_stock(2, 2, @count);

-- 고객, 주문, 배송, 상품 
-- 주문취소가 일어나면 -> 주문테이블에서 행 하나 삭제 / 배송 테이블에서도 주문번호로 join한 행 삭제 / 상품의 재고가 취소수량만큼 추가 

-- 결과를 확인합니다.
SELECT @count;

-- IF 문을 사용한 스토어드 프로시저: 
-- emp 테이블을 활용하여 hiredate가 1984년 이전인 직원들의 수를 세는 스토어드 프로시저 예제를 만들어보세요.
-- procedure 이름은 employees_hireyear로 지정합니다.
SELECT * FROM fisa.emp;
USE fisa;
DROP PROCEDURE employees_hireyear;
SELECT * FROM emp WHERE hiredate < '1984-01-01 00:00:00'; 

-- // 로 구분자를 사용하겠음 
DELIMITER $$

CREATE PROCEDURE employees_hireyear(OUT employee_count INT)
BEGIN
	-- emp 테이블의 hiredate가 1984-01-01 00:00:00 보다 먼저인지 확인해서 개수를 세는 쿼리를 작성해주세요. 
    SELECT COUNT(*) INTO  employee_count
    FROM emp WHERE hiredate < '1984-01-01 00:00:00'; 
END $$

-- ; 으로 sql 쿼리문의 마침표를 원복하겠음
DELIMITER ;

SET @employee_count = 0;

CALL employees_hireyear(@employee_count);

SELECT @employee_count;


-- student_mgmt 에서 나이 많은 찾는 사람을 찾는 procedure
DROP DATABASE IF EXISTS student_mgmt;
CREATE DATABASE student_mgmt DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE student_mgmt;
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id TINYINT NOT NULL AUTO_INCREMENT, -- 숫자 자동 생성
  name VARCHAR(10) NOT NULL, 
  gender ENUM('man','woman') NOT NULL,
  birth DATE NOT NULL,
  english TINYINT NOT NULL,
  math TINYINT NOT NULL,
  korean TINYINT NOT NULL,
  PRIMARY KEY (id) -- 기본키
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('dave', 'man', '1983-07-16', 90, 80, 71);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('minsun', 'woman', '1982-10-16', 30, 88, 60);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('david', 'man', '1982-12-10', 78, 77, 30);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jade', 'man', '1979-11-1', 45, 66, 20);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('jane', 'man', '1990-11-12', 65, 32, 90);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('wage', 'woman', '1982-1-13', 76, 30, 80);
INSERT INTO students (name, gender, birth, english, math, korean) VALUES ('tina', 'woman', '1982-12-3', 87, 62, 71);





use student_mgmt;

-- gender가 'man'인 학생들의 수를 세는 스토어드 프로시저 예제
DELIMITER //
CREATE PROCEDURE count_men()
BEGIN
    DECLARE count INT; -- 지역변수 선언
    SELECT COUNT(*) INTO count FROM students WHERE gender = 'man';
    -- if ~ else 밖에 없습니다.
    IF count > 3 THEN
        SELECT 'Many men' AS result;
    ELSE
        SELECT 'Few men' AS result;
    END IF;
END //
DELIMITER ;

select * from students;
call count_men();

/* 
2. SQL 함수
- 특정 작업을 수행하고 값을 반환하는 데 사용됩니다.
- 항상 값을 반환합니다. 단일 값 또는 테이블 형식의 값을 반환할 수 있습니다.
- SELECT 문, WHERE 절, JOIN 절 등에서 사용할 수 있습니다.
- 데이터베이스 상태를 변경할 수 없습니다. 즉, INSERT, UPDATE, DELETE 문을 사용할 수 없습니다.

	DELIMITER //

	CREATE FUNCTION function_name(parameter_name parameter_type, ...)
	RETURNS return_type
	DETERMINISTIC  -- 함수가 동일한 입력에 대해 항상 동일한 출력을 반환함을 나타냅니다.
	BEGIN
		-- 변수 선언
		DECLARE variable_name variable_type;

		-- 함수 로직
		-- 예: SELECT ... INTO variable_name FROM ... WHERE ...;

		-- 반환 값
		RETURN variable_name;
	END //

	DELIMITER ;

SELECT sakila.inventory_in_stock(2);
-- inventory_id가 1인 경우 재고 여부를 확인합니다.
-- 이 구문을 실행하면 inventory_id가 1인 경우 재고에 있는지 여부를 확인할 수 있습니다.
-- 결과는 1(재고 있음) 또는 0(재고 없음)으로 표시됩니다.

*/
-- // 로 구분자를 사용하겠음 
USE fisa;

DELIMITER $$

CREATE FUNCTION employees_hireyear()
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE employee_count INT;
    
	-- emp 테이블의 hiredate가 1984-01-01 00:00:00 보다 먼저인지 확인해서 개수를 세는 쿼리를 작성해주세요. 
    SELECT COUNT(*) INTO  employee_count
    FROM emp WHERE hiredate < '1984-01-01 00:00:00'; 

	RETURN employee_count;
END $$

-- ; 으로 sql 쿼리문의 마침표를 원복하겠음
DELIMITER ;


-- ?? 함수를 호출하여 결과를 확인합니다.

SELECT employees_hireyear();

SELECT * FROM emp WHERE hiredate >  employees_hireyear();

/* 
3. TRIGGER
- 사전적 의미로 '방아쇠'라는 뜻으로, MySQL에서 트리거는 테이블에서 어떤 이벤트가 발생했을 때 자동으로 실행되는 것을 말합니다.
- 즉, 어떤 테이블에서 특정한 이벤트(update, insert, delete)가 발생했을 때, 실행시키고자 하는 추가 쿼리 작업들을 자동으로 수행할 수 있게끔 트리거를 미리 설정해 두는 것입니다. 
- 트리거는 직접 실행시킬 수 없고 오직 해당 테이블에 이벤트가 발생할 경우에만 실행됩니다. 
- DML에만 작동되며, MySQL에서는 VIEW에는 트리거를 사용할 수 없습니다.

	DELIMITER $$

	CREATE TRIGGER 트리거이름
		AFTER DELETE -- 트리거를 달 동작
		ON 테이블 FOR EACH ROW
	BEGIN
		-- 문장
	END $$    

	DELIMITER ;

- BEFORE/AFTER는 명령 키워드가 사용된 후에 처리할지 아니면 끝난 후 처리할지를 나타냅니다.
- 또한 처리할 내용 부분에서 OLD, NEW로 명령 키워드로 변경되는 테이블에 접근할 수 있습니다.
    - ( OLD : 변경되기 전 테이블, NEW : 변경된 후 테이블 )
- 프로시저는 특정 경우에만 동작시킨다면, 트리거는 매번 DML이 실행될 때마다 동작합니다.
- truncate는 commit까지 완료되므로 trigger를 부착할 수 없습니다.

*/

CREATE DATABASE market;
USE market;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(30)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 주문을 취소했을 때 ORDER 테이블에서 주문정보가 삭제되면, backup_order라는 테이블에 넘겨서 관리함 
CREATE TABLE backup_order (
    backup_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    quantity INT
);

INSERT INTO customers (name, email) VALUES 
('김철수', 'chulsoo.kim@example.com'),
('박영희', 'younghee.park@example.com'),
('이민수', 'minsoo.lee@example.com');

INSERT INTO products (name, price) VALUES 
('노트북', 1200.00),
('스마트폰', 800.00),
('헤드폰', 150.00);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES 
(1, 1, '2024-07-21 10:30:00', 1),
(2, 3, '2024-07-21 11:00:00', 2),
(3, 2, '2024-07-21 11:30:00', 1);


DROP TRIGGER IF EXISTS test_trg;

DELIMITER // 
CREATE TRIGGER test_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON market.orders -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '주문 정보가 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;

SELECT * FROM orders;
SELECT @msg;
DELETE FROM market.orders WHERE order_id=3;

SELECT @msg;

-- 테이블 기준으로 테이블에 붙어있는 트리거를 확인하는 명령어입니다.
SHOW TRIGGERS LIKE 'orders';

DROP TABLE IF EXISTS backup_order;

DROP TRIGGER IF EXISTS backtable_update_trg;

DELIMITER // 
CREATE TRIGGER backtable_update_trg  -- 트리거 이름
    AFTER DELETE -- 삭제후에 작동하도록 지정
    ON market.orders -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	INSERT INTO backup_order (order_id, customer_id, product_id, order_date, quantity)
    VALUES (OLD.order_id, OLD.customer_id, OLD.product_id, OLD.order_date, OLD.quantity);
	-- OLD / NEW 
END // 

DELIMITER ;

DELETE FROM orders WHERE order_id=2;

SELECT * FROM backup_order;


-- 트리거는 테이블에 몇개라도 부착할 수 있습니다.
SELECT @msg;

/* 9. Partition

MySQL에서 테이블 파티션은 큰 테이블을 더 작은, 더 관리하기 쉬운 부분으로 나누는 방법입니다. 이를 통해 쿼리 성능을 향상시키고 데이터 관리를 용이하게 할 수 있습니다. 파티션은 물리적으로는 하나의 테이블이지만, 논리적으로는 여러 개의 작은 테이블처럼 동작합니다.

주요 파티션 유형

- RANGE 파티션
    특정 범위의 값을 기준으로 데이터를 분할합니다.
    예: 날짜 범위, 숫자 범위 등.

- LIST 파티션
    특정 값 목록을 기준으로 데이터를 분할합니다.
    예: 특정 지역 코드, 상태 코드 등.

- HASH 파티션
    해시 함수를 사용하여 데이터를 균등하게 분할합니다.
    예: 특정 열의 해시 값을 기준으로 분할.

- KEY 파티션
    MySQL의 내부 해시 함수를 사용하여 데이터를 분할합니다.
    HASH 파티션과 유사하지만, MySQL이 해시 함수를 자동으로 선택합니다.


파티션의 장점
- 성능 향상: 특정 파티션만 스캔하여 쿼리 성능을 향상시킬 수 있습니다.
- 관리 용이성: 데이터 삭제, 백업, 복구 작업이 더 쉬워집니다.
- 병렬 처리: 여러 파티션에서 동시에 작업을 수행할 수 있습니다.

파티션의 단점
- 테이블 설계와 관리가 더 복잡해질 수 있습니다.
  파티션 키를 신중하게 선택해야 하며, 잘못된 선택은 성능 저하를 초래할 수 있습니다. 
- 외래 키제약 조건을 사용할 수 없습니다. 
- 파티션된 테이블의 유지 관리가 더 복잡할 수 있습니다.
- 파티션된 테이블은 인덱스와 메타데이터를 각 파티션마다 유지해야 하므로 디스크 공간 사용이 증가할 수 있습니다.
*/ 

CREATE TABLE emp_p (
    empno INT NOT NULL AUTO_INCREMENT,
    ename VARCHAR(50),
    hiredate DATE,
    PRIMARY KEY (empno, hiredate)
)
PARTITION BY RANGE (YEAR(hiredate)) (
    PARTITION p0 VALUES LESS THAN (1980),
    PARTITION p1 VALUES LESS THAN (1982),
    PARTITION p2 VALUES LESS THAN (1984),
    PARTITION p3 VALUES LESS THAN (1986),
    PARTITION p4 VALUES LESS THAN (1988),
    PARTITION p5 VALUES LESS THAN MAXVALUE
) 
SELECT empno, ename, hiredate FROM emp;

SHOW CREATE TABLE emp_p;

SELECT 
    PARTITION_NAME, 
    PARTITION_ORDINAL_POSITION, 
    PARTITION_METHOD, 
    PARTITION_EXPRESSION, 
    PARTITION_DESCRIPTION 
FROM 
    INFORMATION_SCHEMA.PARTITIONS 
WHERE 
    TABLE_NAME = 'emp_p' 
    AND TABLE_SCHEMA = 'fisa';


-- 실습2
USE fisa;
SELECT years FROM box_office WHERE years BETWEEN 2014 AND 2017;

DROP TABLE IF EXISTS box_office_p;

CREATE TABLE box_office_p AS
SELECT * FROM box_office;


ALTER TABLE box_office_p
    PARTITION BY RANGE(years) (
        PARTITION p0 VALUES LESS THAN (2004),
        PARTITION p1 VALUES LESS THAN (2005),
        PARTITION p2 VALUES LESS THAN (2006),
        PARTITION p3 VALUES LESS THAN (2007),
        PARTITION p4 VALUES LESS THAN (2008),
        PARTITION p5 VALUES LESS THAN (2009),
        PARTITION p6 VALUES LESS THAN (2010),
        PARTITION p7 VALUES LESS THAN (2011),
        PARTITION p8 VALUES LESS THAN (2012),
        PARTITION p9 VALUES LESS THAN (2013),
        PARTITION p10 VALUES LESS THAN (2014),
        PARTITION p11 VALUES LESS THAN (2015),
        PARTITION p12 VALUES LESS THAN (2016),
        PARTITION p13 VALUES LESS THAN (2017),
        PARTITION p14 VALUES LESS THAN (2018),
        PARTITION p15 VALUES LESS THAN (2019),
        PARTITION p16 VALUES LESS THAN (MAXVALUE)  -- Catch-all partition
    );
   
    SELECT years FROM box_office_p WHERE years BETWEEN 2014 AND 2017;