------- Total records ---------------
SELECT 
    COUNT(*) 
FROM 
    foods;

---------- Unique brands ---------------

SELECT 
    COUNT(DISTINCT brand_name)
FROM 
    foods;

--countries count----------

SELECT 
    COUNT(DISTINCT country) as country_count
FROM
    foods;

---------- countries and Unique cities counts ---------------

SELECT 
    country,
    COUNT(DISTINCT city) as city_count
FROM 
    foods
GROUP BY
    country
ORDER BY
    city_count DESC;



----------- brand outlet counts by country ---------------

SELECT 
    DISTINCT city,
    country,
    brand_name,
    COUNT(brand_name) as total_outlet_count
FROM 
    foods
GROUP BY
    country,city,brand_name
ORDER BY
    total_outlet_count DESC;
