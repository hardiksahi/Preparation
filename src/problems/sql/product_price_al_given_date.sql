-- https://leetcode.com/problems/product-price-at-a-given-date/?envType=study-plan-v2&envId=top-sql-50

-- WITH T1 AS (
--     SELECT
--         PRODUCT_ID,
--         CHANGE_DATE,
--         NEW_PRICE
--     FROM
--         PRODUCTS
--     WHERE
--         CHANGE_DATE <= '2019-08-16'
-- ), T2 AS (
--     SELECT
--         PRODUCT_ID,
--         MAX(CHANGE_DATE) AS LATEST_CHANGE_DATE
--     FROM
--         T1
--     GROUP BY
--         PRODUCT_ID
-- ), T3 AS (
--     SELECT
--         T2.PRODUCT_ID,
--         T1.NEW_PRICE  AS PRICE
--     FROM
--         T2
--         LEFT JOIN T1
--         ON T2.PRODUCT_ID = T1.PRODUCT_ID
--         AND T2.LATEST_CHANGE_DATE = T1.CHANGE_DATE
-- )
-- SELECT
--     *
-- FROM
--     T3
-- UNION
-- SELECT
--     PRODUCT_ID,
--     10
-- FROM
--     PRODUCTS
-- WHERE
--     PRODUCT_ID NOT IN (
--         SELECT
--             DISTINCT(PRODUCT_ID)
--         FROM
--             T3
--     );


WITH T1 AS (
    SELECT
        DISTINCT PRODUCT_ID,
        LAST_VALUE(NEW_PRICE) OVER( PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE ASC ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING ) AS PRICE
    FROM
        PRODUCTS
    WHERE
        CHANGE_DATE <= '2019-08-16'
)
SELECT
    A.PRODUCT_ID,
    COALESCE(T1.PRICE, 10) AS PRICE
FROM
    (
        SELECT
            DISTINCT(PRODUCT_ID) AS PRODUCT_ID
        FROM
            PRODUCTS
    )  AS A
    LEFT JOIN T1
    ON A.PRODUCT_ID = T1.PRODUCT_ID;