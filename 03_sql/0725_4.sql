SET @country_name = 'AGO';
	SELECT * FROM world.country WHERE code = 'AGO';
	SELECT * FROM world.country WHERE code = @country_name;

-- ----------------
SET @count = 5;
	SELECT code, name, continent, region, population
	FROM country
	ORDER BY @count; # 적용되지 않는다
    
	SELECT code, name, continent, region, population
	FROM country
	LIMIT @count; # 작동하지 않는다

-- ----------------
SET @count = 5;
	PREPARE mySQL 
		FROM '
			SELECT code, name, continent, region, population
			FROM world.country
			WHERE population > 100000000
			ORDER BY 1 ASC
			LIMIT ?';
	EXECUTE mySQL USING @count;