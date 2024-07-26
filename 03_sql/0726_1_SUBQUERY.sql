USE fisa;

-- 스칼라 서브쿼리 : 결과가 하나의 값으로 도출
-- 내부쿼리 -> 외부쿼리 동작
-- 내부쿼리에서는 외부쿼리의 FROM 절에 사용한 테이블을 참조할 수 있다
-- 외부쿼리에서는 내부쿼리에서 사용한 테이블을 참조할 수 없다
-- SELECT 절에는 스칼라 서브쿼리만 쓸 수 있습니다. 

SELECT  e.ename, d.dname 
		FROM dept d, emp e 
		WHERE e.deptno = d.deptno
        AND d.dname = 'ACCOUNTING';

-- subquery로 해결
SELECT e.ename,
       (SELECT d.dname 
		FROM dept d 
		WHERE d.deptno = e.deptno) AS dep_name
FROM emp e
WHERE (SELECT d.dname 
		FROM dept d 
		WHERE d.deptno = e.deptno) = 'ACCOUNTING';
        
SELECT e.ename,
       (SELECT d.dname 
        FROM dept d 
        WHERE d.deptno = e.deptno) AS dep_name
FROM emp e
WHERE e.deptno = (SELECT d.deptno 
                  FROM dept d 
                  WHERE d.dname = 'ACCOUNTING');


-- USING JOIN
SELECT e.ename, d.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.dname = 'ACCOUNTING';

-- USING SUB QUERY
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname='ACCOUNTING');


-- 2. FROM 절에서의 서브쿼리
-- 파생(derived) 서브쿼리
-- 꼭 별칭을 붙여서 외부 쿼리문에서는 별칭으로 사용합니다.
-- 서브쿼리가 반환하는 결과 집합을 하나의 테이블처럼 사용하는 쿼리문
-- 서브쿼리 안에서 사용해도 된다 
-- FROM -> WHERE -> SELECT 

SELECT b.deptno, b.empno, c.ename
FROM emp b, emp c
WHERE b.empno = c.empno;
                     
SELECT a.deptno, a.dname
FROM dept a
ORDER BY 1;


SELECT b.deptno, b.empno, c.ename
					  FROM emp b,
					       emp c
					 WHERE b.empno = c.empno;

SELECT a.deptno, a.dname, mgr.empno -- 각 부서의 매니저 번호
  FROM dept a,
	(SELECT b.deptno, b.empno, c.ename
					  FROM emp b,
					       emp c
					 WHERE b.empno = c.empno) mgr -- FROM 절 서브쿼리는 원본에서 재생성한 테이블이기 때문에 꼭 별칭을 가지는 게 문법 
 ORDER BY 1;
                     
 -- join으로 해결
 -- emp 테이블에서 SMITH 직원명 검색해서 
 -- 어떤 부서인지 dept 테이블에서 찾아서 출력하기
SELECT d.deptno, d.dname, mgr.empno
FROM
	dept d,
    (SELECT 
		e.deptno, e.empno, m.ename
	FROM emp e, emp m
    WHERE e.mgr = m.empno
    ) AS mgr;


 

-- 3. WHERE절의 서브쿼리
-- - 특정 데이터를 걸러내기 위한 일반 조건이나 조회 조건을 기술 
-- 비교 연산자 또는 ANY(~ 중 하나), SOME(하나라도 있으면), ALL(모두) 연산자를 사용하기도 함

SELECT e.ename
FROM emp e
WHERE e.ename='SMITH';

SELECT d.dname
FROM dept d
WHERE d.deptno=????;

 -- subquery로 해결
-- SMITH씨와 동일한 RESEARCH 부서 가진 모든 사원의 이름을 출력해보세요
SELECT e.ename
FROM emp e
WHERE
	e.deptno = (SELECT e.deptno
				FROM emp e
				WHERE e.ename='SMITH');



-- ANY, SOME, ALL 이라는 조건을 사용해서 여러개의 결과값과 비교를 할 수도 있습니다.
-- ANY, SOME : 서브쿼리의 결과값 중 하나라도 만족하면 참
-- ALL : 서브쿼리의 결과값 모두 만족해야 참
-- SMITH 씨랑 급여가 같거나 더 많은 사원명과 급여를 검색해주세요
SELECT e.ename, e.sal
FROM emp e
WHERE e.sal >= (SELECT e2.sal FROM emp e2 WHERE e2.ename = 'SMITH');

-- 급여가 3000불 이상인 사원이 소속된 부서(10, 20)에 속한 사원이름, 급여 검색
SELECT e.*
FROM emp e
WHERE (SELECT e.sal WHERE e.deptno = 10 OR e.deptno = 20) >= 3000;


-- EXISTS 연산자는 메인쿼리 테이블의 값 중에서 서브쿼리의 결과 집합에
-- 존재하는 건이 있는지를 확인하는 역할

-- EXISTS                  
-- 서브쿼리의 결과값이 존재하면 참
SELECT
	*
FROM emp e
WHERE sal >= 3000 AND deptno in (10,20)
AND EXISTS (SELECT 1 FROM emp e2);



-- 각 부서별로 SAL가 가장 높은 사람은 누구일까요? 
-- 서브쿼리에 group by를 사용할 수 있다 
-- group by로는 볼 수 없던 행별 정보를 서브쿼리로 추출한 테이블로 필터링해서 꺼낼 수 있다 
SELECT MAX(e.sal), e.deptno
FROM emp e
GROUP BY e.deptno;

SELECT ename, sal, deptno
FROM emp
WHERE (sal, deptno) IN 
			(SELECT MAX(sal), deptno
			FROM emp
			GROUP BY deptno);
            
            

-- IN 연산자는 여러개 컬럼의 값을 비교해서 꺼낼 수 있습니다
-- 단 순서가 맞아야 합니다 


-- job이 매니저인 사람이 어느 부서에만 있는지 서브쿼리를 통해 확인해보세요 


-- 실습

-- 2018년에 가장 많은 매출을 기록한 영화보다 더 많은 매출을 기록한 2019년도 영화를 검색해주세요    
SELECT MAX(sale_amt)
FROM box_office
WHERE release_date LIKE '2018%';

SELECT movie_name, sale_amt
FROM box_office
WHERE sale_amt > (SELECT MAX(sale_amt)
					FROM box_office
					WHERE release_date LIKE '2018%')
AND release_date LIKE '2019%';

-- 2018 top 5 보다 더 많이 번 영화
SELECT movie_name, sale_amt
FROM box_office
WHERE sale_amt > ANY (SELECT sale_amt
					FROM box_office
					WHERE release_date LIKE '2018%'
                    ORDER BY 1 DESC LIMIT 5)
AND release_date LIKE '2019%';




-- 2019년에 개봉한 영화 중 2018년에는 개봉하지 않았던 영화의 순위, 영화명, 감독을 검색해주세요
SELECT movie_name
FROM box_office
WHERE release_date NOT LIKE '2018%'
GROUP BY movie_name;

SELECT ranks, movie_name, director, release_date
FROM box_office
WHERE movie_name IN (SELECT movie_name
					FROM box_office
					WHERE release_date NOT LIKE '2018%'
					GROUP BY movie_name)
AND release_date LIKE '2019%';

SELECT ranks, movie_name, director, release_date
FROM box_office
WHERE movie_name NOT IN (SELECT movie_name
					FROM box_office
					WHERE release_date LIKE '2018%'
					GROUP BY movie_name)
AND release_date LIKE '2019%';

SELECT ranks, movie_name, director, release_date
FROM box_office
WHERE EXISTS (SELECT movie_name
					FROM box_office
					WHERE release_date NOT LIKE '2018%'
					GROUP BY movie_name)
AND release_date LIKE '2019%';




-- 2018년에도 개봉했고, 2019년에 다시 개봉한 영화의 순위, 영화명, 감독을 검색해주세요.
SELECT ranks, movie_name, director, release_date
FROM box_office
WHERE movie_name IN (SELECT movie_name
					FROM box_office
					WHERE release_date LIKE '2018%'
					GROUP BY movie_name)
AND release_date LIKE '2019%';

SELECT ranks, movie_name, director, release_date
FROM box_office
WHERE release_date LIKE '2019%'
AND EXISTS (SELECT movie_name
			FROM box_office
			WHERE release_date LIKE '2018%'
			GROUP BY movie_name);

-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
-- 행이 많으면 속도가 느려지기 때문에 가장 행을 앞단에서 줄일 수 있는 순서
-- 테이블은 메인쿼리에서 먼저 가져옵니다 
-- 여기에 더해서 서브쿼리가 먼저 동작하기 때문에 서브쿼리를 최대한 간소한 결과가 나오도록 작성해주시면 좋습니다 

                       
-- 어차피 동작도 서브쿼리부터 하고, 서브쿼리가 길어서 뭘 하는지 안 보인다면 
-- 따로 빼줘도 좋지 않을까요 
-- CTE, Common Table Expression FROM 절에서는 사용하기 위한 파생 테이블의 별명을 붙여서 사용할 수 있습니다 
USE fisa;

WITH mgr AS (SELECT b.deptno, b.empno, c.ename
			 FROM emp b, emp c
			 WHERE b.empno = c.empno)  -- AS 뒤에 있는 쿼리로 만들어진 테이블을 메인쿼리에서 mgr이라고 부르겠다 
SELECT a.deptno, a.dname, mgr.empno
FROM dept a, mgr -- mgr이라고 부르고 있습니다 
WHERE a.deptno = mgr.deptno
ORDER BY 1;
 
 
 
use fisa;
-- CTE는 FROM 절에서만 쓸 수 있다 (테이블이기 때문에)

## SQL 실행순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

-- 모든 부서의 정보와 함께 커미션이 있는 직원들의 커미션과 이름을 조회해 보세요.
WITH emp_dept AS (SELECT e.ename, e.sal, e.comm, d.dname FROM dept d, emp e WHERE d.deptno = e.deptno)
SELECT ename, sal, comm, dname
FROM emp_dept;

-- 모든 부서의 부서별 연봉에 대한 총합과 평균과 표준편차를 구하고
-- 모든 부서의 사원수를 구해 보세요.
WITH stat AS (SELECT SUM(sal) sum, AVG(sal) avg, STDDEV(sal) stdev, deptno
			FROM emp
			GROUP BY deptno),
	cnt AS (SELECT COUNT(empno) cnt, deptno
			FROM emp
			GROUP BY deptno)
SELECT stat.deptno, stat.sum, stat.avg, stat.stdev, cnt.cnt
FROM stat, cnt
WHERE stat.deptno = cnt.deptno;
    

-- 각 관리자의 부하직원수와 부하직원들의 평균연봉을 구해 보세요.
SELECT m.ename, e.mgr, COUNT(m.empno), AVG(m.sal)
FROM emp e, emp m
WHERE e.mgr = m.empno
GROUP BY e.mgr;


#Sub-Query 
-- 쿼리 안쪽에 쿼리를 넣을수 있다.
-- where 절에서의 서브쿼리
-- scott과 같은 부서에 있는 직원 이름을 검색해 보세요.
SELECT e.ename
FROM emp e
WHERE e.deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT');

-- 직무(job)가 Manager인 사람들이 속한 부서의 부서번호와 부서명 , 지역을 조회해 보세요.
	-- manager 사람들이 다수이기 때문에 where절에 in 을 활용!
SELECT d.deptno, d.dname, d.loc
FROM dept d 
WHERE d.deptno IN (SELECT e.deptno
		FROM emp e
		WHERE e.job = 'MANAGER');

# from 절에서의 서브쿼리
-- emp 테이블에서 급여가 2000이 넘는 사람들의 이름과 부서번호, 부서이름, 지역 조회해 보세요.
SELECT e.ename, e.deptno, d.loc
FROM emp e, (SELECT loc, deptno FROM dept) d
WHERE e.sal > 2000 AND e.deptno = d.deptno;

-- emp 테이블에서 커미션이 있는 사람들의 이름과 부서번호, 부서이름, 지역을 조회해 보세요.
SELECT e.ename, e.deptno, d.loc
FROM emp e, (SELECT loc, deptno FROM dept) d
WHERE e.deptno = d.deptno AND e.comm IS NOT NULL;


-- join 절에서의 서브쿼리
-- 모든 부서의 부서이름과, 지역, 부서내의 평균 급여를 조회해 보세요.
WITH cal AS (SELECT AVG(sal) avg, deptno FROM emp GROUP BY deptno)
SELECT d.dname, d.loc, cal.avg
FROM dept d LEFT OUTER JOIN cal ON cal.deptno = d.deptno;