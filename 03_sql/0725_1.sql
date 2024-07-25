
SELECT count(*) FROM fisa.box_office;
SELECT * FROM fisa.box_office;

USE fisa;
SELECT 
    movie_name AS "제목",
    release_date,
    genre,
    director AS '감독'
FROM
    box_office
WHERE
    years BETWEEN 2002 AND 2006;


    
SELECT 
    movie_name
FROM
    box_office
WHERE
	movie_name LIKE "%학%" || movie_name LIKE "%여우%";
    
SELECT 
    movie_name
FROM
    box_office
WHERE
	years LIKE 2007 && movie_name LIKE "%여우%";
    
SELECT 
    movie_name
FROM
    box_office
WHERE
	years LIKE 2007 && movie_name LIKE "%여우%";
    
    
    


SELECT * FROM box_office;
    
-- - 2018년 개봉한 한국 영화 조회하기
SELECT movie_name FROM box_office WHERE (release_date BETWEEN DATE("2018-01-01") AND DATE("2019-01-01")) AND rep_country = "한국";
-- - 2019년 개봉 영화 중 관객수가 500만 명 이상인 영화 조회하기
SELECT movie_name FROM box_office WHERE audience_num >= 5000000;
-- - 2019년 개봉 영화 중 관객수가 500만 명 이상이거나 매출액이 400억 원 이상인 영화 조회하기
SELECT movie_name FROM box_office WHERE sale_amt >= 40000000000 && audience_num >= 5000000;
-- - 2012년에 제작됐지만, 2019년에 개봉된 영화를 조회하기.
SELECT movie_name FROM box_office WHERE years LIKE 2012 AND (release_date BETWEEN DATE("2019-01-01") AND DATE("2020-01-01"));
-- - 위 데이터를 “특이사항”이라는 열 이름으로 출력하기.
SELECT movie_name AS "특이사항" FROM box_office WHERE years LIKE 2012 AND release_date LIKE "2019%";

-- -  2019년 개봉하고 500만 명 이상의 관객을 동원한 매출액 기준 상위 5편의 영화만 조회
SELECT movie_name FROM fisa.box_office WHERE audience_num >= 5000000 ORDER BY sale_amt DESC LIMIT 5;

-- -  2019년 제작한 영화 중 관객수 1~10위 영화를 조회
SELECT movie_name FROM fisa.box_office WHERE years LIKE 2019 ORDER BY audience_num DESC LIMIT 10;

-- - box_office 테이블에서 2019년 제작된 영화 중 영화 유형(movie_type 칼럼)이 장편이 아닌 영화를 순위(ranks)대로 조회.
SELECT movie_name FROM fisa.box_office WHERE years LIKE 2019 AND movie_type != "장편" ORDER BY ranks ASC;


-- - box_office 데이터에서 연도별 개봉한 영화의 편수를 집계해서 출력해주세요
SELECT YEAR(release_date), COUNT(movie_name) FROM fisa.box_office GROUP BY YEAR(release_date) ORDER BY YEAR(release_date);

-- - box_office 데이터에서 2019년 개봉 영화의 유형별 최대, 최소 매출액과 전체 매출액 집계해주세요.
SELECT
    movie_type, SUM(sale_amt), MAX(sale_amt), MIN(sale_amt)
FROM
    fisa.box_office
WHERE
    release_date LIKE "2019%" AND movie_type IS NOT NULL
GROUP BY movie_type;



SELECT
    movie_type, SUM(sale_amt), MAX(sale_amt), MIN(sale_amt)
FROM
    fisa.box_office
WHERE
    release_date LIKE "2019%"
GROUP BY 
	movie_type
HAVING 
	movie_type IS NOT NULL;
    
    
SELECT
    movie_type, SUM(sale_amt), MAX(sale_amt), MIN(sale_amt)
FROM
    fisa.box_office
WHERE
    release_date LIKE "2019%" AND movie_type IS NOT NULL
GROUP BY 
	movie_type
WITH ROLLUP;

