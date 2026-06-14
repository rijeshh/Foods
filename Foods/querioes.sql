
--------------Average calories and price by item category-------------------

SELECT
    item_category,
    ROUND(AVG(calories)::numeric, 2) as avg_calories,
    ROUND(AVG(price_usd_normalized)::numeric, 2) as avg_price
FROM
    foods
GROUP BY
    item_category;

 
--------------Top rated food items-------------------

SELECT
    item_name,
    item_category,        
    brand_name,
    country,
    price_usd_normalized,
    avg_rating
FROM
    foods
ORDER BY
    avg_rating DESC
LIMIT 10;


--------------Average rating and price by brand-------------------

SELECT
    brand_name,
    brand_tier,
    ROUND(AVG(avg_rating) :: numeric, 2) as avg_brand_rating,
    ROUND(AVG(price_usd_normalized) :: numeric, 2) as avg_brand_item_price
FROM
    foods
GROUP BY
    brand_name, brand_tier
ORDER BY
    avg_brand_rating DESC


-----

SELECT
    