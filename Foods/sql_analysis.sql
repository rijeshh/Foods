
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


------ brand performance (avg ratings and price) -----------------------

SELECT
    item_name,
    ROUND(AVG(avg_rating) :: numeric, 2) AS rating,
    ROUND(AVG(price_usd_normalized) :: numeric, 2) AS avg_price
FROM 
    foods
GROUP BY 
    item_name
ORDER BY 
    rating DESC
LIMIT 10;

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