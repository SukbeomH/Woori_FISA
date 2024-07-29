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


-- OUT 매개변수를 저장할 변수를 선언합니다.



-- 저장 프로시저를 호출합니다.


-- 결과를 확인합니다.

-- IF 문을 사용한 스토어드 프로시저: 
-- emp 테이블을 활용하여 hiredate가 1984년 이전인 직원들의 수를 세는 스토어드 프로시저 예제를 만들어보세요.
-- procedure 이름은 employees_hireyear로 지정합니다.

SELECT * FROM fisa.emp;
USE fisa;


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



-- ?? 함수를 호출하여 결과를 확인합니다.


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

DELETE FROM market.orders WHERE order_id=3;

SELECT @msg;
SHOW TRIGGERS LIKE 'orders';
DROP TABLE IF EXISTS backup_order;
CREATE TABLE backup_order
	(backup_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATETIME,
    cancle_date DATETIME,
    quantity INT);

DROP TRIGGER IF EXISTS backtable_update_trg;

