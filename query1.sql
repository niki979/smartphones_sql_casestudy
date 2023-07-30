select * from smartphones;

-- How many smartphone models are there in the table?
select count(id) as total_models from smartphones;

-- Which brand has the highest-priced smartphone?
select brand,name,price from smartphones where price=(select max(price) from smartphones);

-- Calculate the average score of smartphones in the dataset.
select avg(score) from smartphones;

-- Find the top 3 smartphones with the highest battery capacity.
select name,brand, battery_capacity,price from smartphones order by battery_capacity desc limit 3;

-- find distribution of smartphone brands
SELECT brand, COUNT(*) AS brand_count,
round(avg(price),2) as avg_price
FROM smartphones
GROUP BY brand order by avg_price desc;

-- 5g distribution
SELECT 
    COUNT(*) AS total_smartphones,
    SUM(has_5g) AS smartphones_with_5g,
    (SUM(has_5g) / COUNT(*) * 100) AS percentage_with_5g
FROM smartphones;

-- Group smartphones based on their OS and calculate the average battery capacity for each group.
select os,avg(battery_capacity) as avg_battery_capacity from smartphones group by os order by avg_battery_capacity desc;

-- Find the average price difference between 5G smartphones and non-5G smartphones:
SELECT AVG(CASE WHEN has_5g = 1 THEN price ELSE NULL END) as has5g_price,AVG(CASE WHEN has_5g = 0 THEN price ELSE NULL END) as non5g_price,AVG(CASE WHEN has_5g = 1 THEN price ELSE NULL END) - AVG(CASE WHEN has_5g = 0 THEN price ELSE NULL END) AS avg_price_difference FROM smartphones;

-- Calculate the difference in price between the highest-priced and lowest-priced smartphones for each brand
SELECT brand, MAX(price) - MIN(price) AS price_range
FROM smartphones
GROUP BY brand order by price_range desc;

-- Calculate the percentage of smartphones for each screen resolution category (e.g., HD, Full HD, Quad HD):
SELECT 
    CASE 
        WHEN resolution LIKE '%1080%' THEN 'Full HD'
        WHEN resolution LIKE '%1440%' THEN 'Quad HD'
        ELSE 'Other'
    END AS resolution_category,
    COUNT(*) / SUM(COUNT(*)) OVER () * 100 AS percentage
FROM smartphones
GROUP BY resolution_category;

-- Calculate the percentage of smartphones that have NFC support:
SELECT 
    COUNT(*) / (SELECT COUNT(*) FROM smartphones) * 100 AS percentage_nfc_support
FROM smartphones
WHERE has_nfc = 1;

-- Calculate the average price of smartphones with and without NFC support:
SELECT 
    AVG(CASE WHEN has_nfc = 1 THEN price END) AS avg_price_nfc_support,
    AVG(CASE WHEN has_nfc = 0 THEN price END) AS avg_price_no_nfc_support
FROM smartphones;


















