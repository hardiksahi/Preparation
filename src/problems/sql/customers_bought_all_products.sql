-- https://leetcode.com/problems/customers-who-bought-all-products/?envType=study-plan-v2&envId=top-sql-50

SELECT
    F.CUSTOMER_ID
FROM
    (
        SELECT
            CUSTOMER_ID,
            COUNT( DISTINCT(PRODUCT_KEY) ) AS ITEMS_BOUGHT
        FROM
            CUSTOMER
        GROUP BY
            CUSTOMER_ID
    ) AS F
WHERE
    F.ITEMS_BOUGHT = (
        SELECT
            COUNT( DISTINCT(PRODUCT_KEY) )
        FROM
            PRODUCT
    );