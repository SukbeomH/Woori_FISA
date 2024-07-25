
-- 6. 조인을 사용해서 뉴욕('NEW YORK')에 근무하는 사원의 이름(ename)과 급여(sal)를 검색 
SELECT e.ename, e.sal
FROM dept d LEFT OUTER JOIN emp e
ON d.loc = 'NEW YORK';

SELECT e.ename, e.sal
FROM emp e LEFT OUTER JOIN dept d 
ON e.deptno = d.deptno
WHERE d.loc = 'NEW YORK';

-- 7. 조인 사용해서 ACCOUNTING 부서(dname)에 소속된 사원의
-- 이름과 입사일 검색
SELECT e.ename, e.hiredate
FROM emp e LEFT OUTER JOIN dept d 
ON e.deptno = d.deptno
WHERE d.dname = 'ACCOUNTING';


-- 8. 직급(job)이 MANAGER인 사원의 이름(ename), 부서명(dname) 검색
SELECT e.ename, d.dname
FROM emp e LEFT OUTER JOIN dept d 
ON e.deptno = d.deptno
WHERE e.job = 'MANAGER';


-- 동등조인 review
-- 9. 사원(emp) 테이블의 부서 번호(deptno)로 
-- 부서 테이블(dept)을 참조하여 사원명(ename), 부서번호(deptno),
-- 부서의 이름(dname) 검색
SELECT e.ename, d.deptno, d.dname
FROM emp e LEFT OUTER JOIN dept d 
ON e.deptno = d.deptno;


-- *** 2. not-equi 조인 ***

-- salgrade table(급여 등급 관련 table)
select * from salgrade s;

-- between ~ and : 포함 
-- 10. 부서번호 30인 사람들의 각 이름, GRADE와 SAL, 상한선, 하한선 출력해주세요
SELECT e.ename, s.grade, s.losal, s.hisal
FROM emp e LEFT OUTER JOIN salgrade s 
ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.deptno = 30;


-- *** 3. self 조인 ***
-- 11. SMITH 직원의 매니저 이름 검색
-- emp e : 사원 table로 간주 / emp m : 상사 table로 간주
SELECT m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno
AND e.ename = 'SMITH';



-- 12. SMITH와 동일한 부서에서 근무하는 사원의 이름 검색
-- 단, SMITH 이름은 제외하면서 검색
SELECT j.*
FROM emp i, emp j
WHERE i.ename = 'SMITH'
AND i.deptno = j.deptno
AND j.ename != 'SMITH';


-- *** 4. outer join ***
/* 두 개 이상의 테이블을 조인할 때 
emp m의 deptno는 참조되는 컬럼(PK)
emp d의 deptno는 참조하는 컬럼(외래키, FK)의 역할을 하게 됩니다

SELECT 컬럼명
FROM A테이블 LEFT JOIN B테이블
WHERE A테이블.컬럼 = B테이블.컬럼 
-- A테이블에는 있고, B테이블에는 없는 값들이 NULL로 출력이 된다 
*/ 



-- 13. 모든 사원명, 매니저 명 검색,  
-- INNER JOIN은 두 테이블 컬럼에 모두 있어야만 출력. 
# NULL인 값은 조회하지 않습니다.
SELECT e.ename AS employee, m.ename AS manager
FROM emp e, emp m
WHERE e.mgr = m.empno;

-- SELECT e.ename AS employee, m.ename AS manager
-- FROM emp e LEFT JOIN emp m
-- ON e.mgr = m.empno;

-- 14. 모든 사원명(KING포함), 매니저 명 검색, 
-- 단 매니저가 없는 사원(KING)도 검색되어야 함
-- LEFT JOIN 사용
SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m 
ON e.mgr = m.empno;



-- RIGHT JOIN 사용
SELECT e.ename, m.ename
FROM emp m RIGHT OUTER JOIN emp e
ON e.mgr = m.empno;


-- 15. 모든 직원명(ename), 부서번호(deptno), 부서명(dname) 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 
SELECT e.ename, d.deptno, d.dname
FROM dept d LEFT OUTER JOIN emp e
ON e.deptno = d.deptno;



-- 16. 모든 부서번호가 검색(40)이 되어야 하며 급여가 3000이상(sal >= 3000)인 사원의 정보 검색
-- 특정 부서에 소속된 직원이 없을 경우 사원 정보는 검색되지 않아도 됨
-- 검색 컬럼 : deptno, dname, loc, empno, ename, job, mgr, hiredate, sal, comm
/*

검색 결과 예시

+--------+------------+----------+-------+-------+-----------+------+------------+---------+------+
| deptno | dname      | loc      | empno | ename | job       | mgr  | hiredate   | sal     | comm |
+--------+------------+----------+-------+-------+-----------+------+------------+---------+------+
|     10 | ACCOUNTING | NEW YORK |  7839 | KING  | PRESIDENT | NULL | 1981-11-17 | 5000.00 | NULL |
|     20 | RESEARCH   | DALLAS   |  7788 | SCOTT | ANALYST   | 7566 | 1987-04-19 | 3000.00 | NULL |
|     20 | RESEARCH   | DALLAS   |  7902 | FORD  | ANALYST   | 7566 | 1981-12-03 | 3000.00 | NULL |
|     30 | SALES      | CHICAGO  |  NULL | NULL  | NULL      | NULL | NULL       |    NULL | NULL |
|     40 | OPERATIONS | BOSTON   |  NULL | NULL  | NULL      | NULL | NULL       |    NULL | NULL |
+--------+------------+----------+-------+-------+-----------+------+------------+---------+------+
*/
SELECT 
    d.deptno,
    d.dname,
    d.loc,
    e.empno,
    e.ename,
    e.job,
    e.mgr,
    e.hiredate,
    e.sal,
    e.comm
FROM
    dept d
        LEFT OUTER JOIN
    emp e ON e.deptno = d.deptno AND e.sal >= 3000;


SELECT 
    d.deptno,
    d.dname,
    d.loc,
    e.empno,
    e.ename,
    e.job,
    e.mgr,
    e.hiredate,
    e.sal,
    e.comm
FROM
    dept d
        LEFT JOIN
    emp e ON d.deptno = e.deptno AND e.sal >= 3000;  -- 정답 

SELECT 
    d.deptno,
    d.dname,
    d.loc,
    e.empno,
    e.ename,
    e.job,
    e.mgr,
    e.hiredate,
    e.sal,
    e.comm
FROM
    dept d
        LEFT JOIN
    emp e ON d.deptno = e.deptno
WHERE
    e.sal >= 3000; -- 무슨 차이지...


-- 17. 세일즈 부서는 sal + comm 이 실제 월급입니다
-- sal + comm 이 2000불 이상인 모든 직원을 검색해 출력해 주세요
SELECT
	d.deptno, d.dname, d.loc, e.empno, e.ename, e.job, e.mgr, e.hiredate,
	CASE WHEN d.dname = 'SALES'
		THEN e.sal + e.comm
        ELSE e.sal
        END sal,
        e.comm
FROM dept d LEFT OUTER JOIN emp e
ON e.deptno = d.deptno
AND sal >= 2000;

SELECT
	d.deptno, d.dname, d.loc, e.empno, e.ename, e.job, e.mgr, e.hiredate,
	CASE WHEN d.dname = 'SALES'
		THEN e.sal + IFNULL(e.comm, 0)
        ELSE e.sal
        END sal,
        e.comm
FROM dept d LEFT OUTER JOIN emp e
ON e.deptno = d.deptno
AND sal >= 2000;


SELECT 
    *
FROM
    emp
WHERE
    (sal + IFNULL(comm, 0)) >= 2000;  -- IFNULL(comm, 0) : NULL이 아니면 comm, NULL이면 0으로 변환해서 연산 