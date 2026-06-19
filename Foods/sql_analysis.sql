
----------- items calories count and avg ratings -----------

SELECT
    item_category,
    ROUND(AVG(calories) :: numeric ,2) as avg_calories,
    ROUND(AVG(avg_rating) :: numeric, 2) as avg_rating
FROM 
    foods
GROUP BY 
    item_category
ORDER BY 
    avg_calories DESC;


------------ country price and ratings (avg ratings and price) -----------------------

SELECT
    country,
    brand_tier,
    COUNT(*) as outlet_count,
    ROUND(AVG(price_usd_normalized) :: numeric, 2) as avg_price,
    ROUND(AVG(avg_rating) :: numeric, 2) as avg_rating
FROM
    foods
GROUP BY
    country,brand_tier
ORDER BY 
    country

------------ protein efficiency (protein per 100 calories) by item subcategory -----------------------

SELECT
    item_subcategory,
    ROUND(AVG(protein_g) :: numeric, 2) as avg_protein_g,
    ROUND(AVG(calories) :: numeric, 2) as avg_calories,
    ROUND((AVG(protein_g)/NULLIF(AVG(calories),0)) :: numeric, 2) * 100 as protein_efficiency_per_100_calories
FROM
    foods
GROUP BY
    item_subcategory
ORDER BY
    protein_efficiency_per_100_calories DESC
LIMIT 10;


---------- sodium warning items --------------------

SELECT
    item_category,
    ROUND(AVG(sodium_mg) :: numeric, 2) as avg_sodium_mg
FROM
    foods
WHERE
    sodium_mg > 800
GROUP BY
    item_category
ORDER BY
    avg_sodium_mg DESC


------ brand performance (avg ratings and price) -----------------------

SELECT
    item_category,
    ROUND(AVG(avg_rating) :: numeric, 2) AS rating,
    ROUND(AVG(price_usd_normalized) :: numeric, 2) AS avg_price
FROM 
    foods
GROUP BY 
    item_category
ORDER BY 
    rating DESC
LIMIT 100;

----------- city tier pricing and ratings -----------------------

SELECT
    city_tier,
    ROUND(AVG(price_usd_normalized) :: numeric, 2) AS avg_price,
    ROUND(AVG(avg_rating) :: numeric, 2) AS avg_rating
FROM 
    foods 
GROUP BY 
    city_tier
ORDER BY 
    avg_price DESC;

----------- top sugar content items --------------------

SELECT
    item_name,  
    item_category,
    sugars_g
FROM
    foods
ORDER BY
    sugars_g DESC
LIMIT 10;


------- rating distribution -----------------------


SELECT
    CASE
        WHEN avg_rating < 3.0                      THEN 'Below 3.0'
        WHEN avg_rating >= 3.0 AND avg_rating < 3.5 THEN '3.0 - 3.5'
        WHEN avg_rating >= 3.5 AND avg_rating < 4.0 THEN '3.5 - 4.0'
        WHEN avg_rating >= 4.0                      THEN 'Above 4.0'
    END                                              AS rating_bucket,
    COUNT(*)                                         AS total_items,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM fast_food
GROUP BY
    CASE
        WHEN avg_rating < 3.0                      THEN 'Below 3.0'
        WHEN avg_rating >= 3.0 AND avg_rating < 3.5 THEN '3.0 - 3.5'
        WHEN avg_rating >= 3.5 AND avg_rating < 4.0 THEN '3.5 - 4.0'
        WHEN avg_rating >= 4.0                      THEN 'Above 4.0'
    END
ORDER BY MIN(avg_rating);


------- bestseller item analysis -----------------------


SELECT
    item_category,
    brand_tier,
    item_subcategory,
    COUNT(*)                                   AS bestseller_count,
    ROUND(AVG(price_usd_normalized), 2)       AS avg_price,
    ROUND(AVG(calories), 2)                   AS avg_calories,
    ROUND(AVG(avg_rating), 2)                 AS avg_rating
FROM fast_food
WHERE is_bestseller = 1
GROUP BY item_category, brand_tier, item_subcategory
ORDER BY bestseller_count DESC;


------- value for money analysis (rating to price ratio) -----------------------


SELECT
    item_name,
    item_category,
    brand_name,
    country,
    price_usd_normalized,
    avg_rating,
    ROUND(avg_rating / NULLIF(price_usd_normalized, 0), 3) AS value_score
FROM fast_food
ORDER BY value_score DESC
LIMIT 10;