-- https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan-v2&envId=top-sql-50
WITH T1 AS (
    SELECT
        DISTINCT SELL_DATE,
        PRODUCT
    FROM
        ACTIVITIES
), T2 AS (
    SELECT
        SELL_DATE,
        COUNT( DISTINCT(PRODUCT) ) AS NUM_SOLD
    FROM
        ACTIVITIES
    GROUP BY
        SELL_DATE
)
 -- SELECT * FROM T2;
SELECT
    L.SELL_DATE,
    T2.NUM_SOLD,
    L.PRODUCTS
FROM
    (
        SELECT
            SELL_DATE,
            GROUP_CONCAT( PRODUCT ORDER BY PRODUCT SEPARATOR ',' ) AS PRODUCTS
        FROM
            T1
        GROUP BY
            SELL_DATE
    ) L
    LEFT JOIN T2
    ON L.SELL_DATE = T2.SELL_DATE;