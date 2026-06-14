DROP TABLE IF EXISTS foods;
CREATE TABLE foods (
		item_name VARCHAR,
		item_category VARCHAR,
		item_subcategory VARCHAR,
		brand_name VARCHAR,
		brand_tier VARCHAR,
		country VARCHAR,
		city VARCHAR,
		city_tier VARCHAR,
		price_usd_normalized FLOAT,
		serving_size_g FLOAT,
		calories FLOAT,
		protein_g FLOAT,
		total_fat_g FLOAT,
		total_carbs_g FLOAT,
		sodium_mg FLOAT,
		sugars_g FLOAT,
		avg_rating FLOAT,
		is_bestseller int default 0
);
SELECT
* FROM
foods limit 100;