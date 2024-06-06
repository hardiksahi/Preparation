-- https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50

WITH T1 AS (
    SELECT
        PRODUCT_ID,
        ROUND( ( SUM(TOTAL_PRICE) / SUM(UNITS) ), 2 ) AS AVERAGE_PRICE
    FROM
        (
            SELECT
                U.PRODUCT_ID,
                (U.UNITS * P.PRICE) AS TOTAL_PRICE,
                U.UNITS
            FROM
                UNITSSOLD U
                CROSS JOIN PRICES P
            WHERE
                ( U.PURCHASE_DATE BETWEEN P.START_DATE
                AND P.END_DATE )
                AND U.PRODUCT_ID = P.PRODUCT_ID
        ) F
    GROUP BY
        PRODUCT_ID
)
SELECT
    *
FROM
    T1
UNION
SELECT
    PRODUCT_ID,
    0 AS AVERAGE_PRICE
FROM
    PRICES P
WHERE
    P.PRODUCT_ID NOT IN (
        SELECT
            DISTINCT(PRODUCT_ID)
        FROM
            T1
    );