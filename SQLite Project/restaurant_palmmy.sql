SELECT "Palmmy Food";

-- database
.open restaurant.db
.mode column
.header on

-- drop table
DROP TABLE foodMenus;
DROP TABLE memberLevel;
DROP TABLE foodTypes;
DROP TABLE customers;
DROP TABLE orders;

-- food types
CREATE TABLE foodTypes (
  typeId INT UNIQUE,
  typeName VARCHAR
);

INSERT INTO foodTypes VALUES
  (1, "Fried rice"),
  (2, "Soup"),
  (3, "Rice"),
  (4, "Noodle");

SELECT * FROM foodTypes;

-- food menus
CREATE TABLE foodMenus (
  foodId INT UNIQUE,
  foodName VARCHAR,
  foodPrice INT,
  typeId INT
);

INSERT INTO foodMenus VALUES
  (1, "Pork Fried Rice", 45, 1),
  (2, "Chicken Fried Rice", 45, 1),
  (3, "Seafood Fried Rice", 50, 1),
  (4, "Tom-Yam Kung", 60, 2),
  (5, "Egg and Pork in Sweet Brown Sauce", 60, 2),
  (6, "Rice with Stir-Fried Pork and Basil Leaves & Chili", 45, 3),
  (7, "Rice with Stir-Fried Chicken and Basil Leaves & Chili", 45, 3),
  (8, "Rice with Stir-Fried Seafood and Basil Leaves & Chili", 50, 3),
  (9, "Pad-Thai Noodle", 45, 4),
  (10, "Pad-Thai Noodle with Seafood", 50, 4),
  (11, "Stir-Fried Rice Noodle with Pork in Gravy", 45, 4),
  (12, "Stir-Fried Rice Noodle with Chicken in Gravy", 45, 4),
  (13, "Stir-Fried Rice Noodle with Seafood in Gravy", 50, 4);

SELECT * FROM foodMenus;

-- member level
CREATE TABLE memberLevel (
  levelId INT UNIQUE,
  levelName VARCHAR
);

INSERT INTO memberLevel VALUES
  (1, "Black Card"),
  (2, "Red Card"),
  (3, "White Card");

SELECT * FROM memberLevel;

-- customers
CREATE TABLE customers (
  custId INT UNIQUE,
  custName VARCHAR,
  custCountry VARCHAR,
  levelId INT
);

INSERT INTO customers VALUES
  (1, "Haaland", "Norway", 1),
  (2, "Alvarez", "Argentina", 2),
  (3, "Mahrez", "Algeria", 2),
  (4, "De Bruyne", "Belgium", 1),
  (5, "Foden", "United Kingdom", 1),
  (6, "Grealish", "United Kingdom", 2),
  (7, "Bernardo", "Portugal", 1),
  (8, "Gomez", "Spain", 3),
  (9, "Lewis", "United Kingdom", 3),
  (10, "Rodri", "Spain", 3);

SELECT * FROM customers;

-- orders
CREATE TABLE orders (
  orderId INT UNIQUE,
  dateOrder TIMESTAMP,
  custId  INT,
  foodId INT
);

INSERT INTO orders VALUES
  (1, "2022-12-01 12:05:47", 1, 4),
  (2, "2022-12-01 12:05:48", 1, 3),
  (3, "2022-12-01 14:34:01", 5, 10),
  (4, "2022-12-02 10:14:23", 3, 5),
  (5, "2022-12-02 10:14:24", 3, 7),
  (6, "2022-12-02 11:13:43", 6,13),
  (7, "2022-12-02 13:45:15", 4, 1),
  (8, "2022-12-02 13:45:15", 4, 4),
  (9, "2022-12-03 09:03:57", 8, 11),
  (10, "2022-12-03 09:03:58", 8, 8),
  (11, "2022-12-03 11:31:02", 2, 10),
  (12, "2022-12-03 11:31:02", 2, 6),
  (13, "2022-12-03 14:22:55", 7, 1),
  (14, "2022-12-03 14:22:56", 7, 5),
  (15, "2022-12-04 15:51:10", 10,12),
  (16, "2022-12-04 15:51:10", 10, 2),
  (17, "2022-12-04 16:13:34", 9, 6);

SELECT * FROM orders;

-- query 1: where clause uk customers
SELECT
  custId,
  custName,
  custCountry AS cc
FROM customers
WHERE cc = 'United Kingdom';

--query 2 join table member lever
SELECT
  custId,
  custName,
  levelName
FROM customers AS cust
LEFT JOIN memberLevel AS ml
  ON cust.levelId = ml.levelId;

-- query 3: aggregate function food type
SELECT
  typeName AS tn,
  COUNT(*) As noFood,
  ROUND(AVG(foodPrice), 2) AS avgPrice,
  SUM(foodPrice) AS sumPrice,
  MIN(foodPrice) AS minPrice,
  MAX(foodPrice) AS maxPrice
FROM foodMenus AS fm
JOIN foodTypes AS ft
  ON fm.typeId = ft.typeId
GROUP BY tn;

-- query 4: subquery top 5 spending
SELECT
  custName,
  SUM(foodPrice) AS sumPrice
FROM (
  SELECT
    cus.custId,
    custName,
    foodName,
    foodPrice
  FROM customers AS cus
  JOIN orders AS ord
    ON cus.custId = ord.custId
  JOIN foodMenus AS fm
    ON ord.foodId = fm.foodId
)
GROUP BY custName
ORDER BY sumPrice DESC
LIMIT 5;

-- query 5: with clause promotion to black card and red card
WITH blackAndRedCard AS (
  SELECT
    custId,
    custName,
    custCountry,
    levelName
  FROM customers AS ct
  JOIN memberLevel AS ml
    ON ct.levelId = ml.levelId
  WHERE levelName IN ('Black Card', 'Red Card')
), orderFood AS (
  SELECT
    custId,
    typeName,
    foodName,
    foodPrice
  FROM orders AS ord
  JOIN foodMenus AS fm
    ON ord.foodId = fm.foodId
  JOIN foodTypes AS ft
    ON fm.typeId = ft.typeId
)

SELECT
  typeName AS tn,
  SUM(foodPrice) AS sumP,
  CASE 
    WHEN SUM(foodPrice) < 150 THEN 'Promotion'
    ELSE 'Not Promotion'
  END AS promotion
FROM blackAndRedCard AS bc
JOIN orderFood AS odf
  ON bc.custId = odf.custId
GROUP BY tn
ORDER BY 2 DESC;
