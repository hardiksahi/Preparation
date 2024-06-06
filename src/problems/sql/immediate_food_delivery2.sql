-- https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    ROUND( ( 100 * SUM(
        CASE
            WHEN DELIVERY_TYPE = 'immediate' THEN
                1
            ELSE
                0
        END )/ COUNT(*) ), 2 ) AS IMMEDIATE_PERCENTAGE
FROM
    (
        SELECT
            DELIVERY_ID,
            CUSTOMER_ID,
            ORDER_DATE,
            CUSTOMER_PREF_DELIVERY_DATE,
            (
                CASE
                    WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN
                        'immediate'
                    ELSE
                        'scheduled'
                END )                                                             AS DELIVERY_TYPE,
            DENSE_RANK() OVER( PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE ASC ) AS ORDER_NUMBER
        FROM
            DELIVERY
    ) F
WHERE
    F.ORDER_NUMBER = 1;