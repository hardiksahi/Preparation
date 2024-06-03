-- https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    MONTH,
    COUNTRY,
    COUNT( DISTINCT(ID) ) AS TRANS_COUNT,
    SUM(
        CASE
            WHEN STATE='approved' THEN
                1
            ELSE
                0
        END)              AS APPROVED_COUNT,
    SUM(AMOUNT)           AS TRANS_TOTAL_AMOUNT,
    SUM(
        CASE
            WHEN STATE='approved' THEN
                AMOUNT
            ELSE
                0
        END)              AS APPROVED_TOTAL_AMOUNT
FROM
    (
        SELECT
            ID,
            COUNTRY,
            AMOUNT,
            STATE,
            DATE_FORMAT(TRANS_DATE, '%Y-%m') AS MONTH
        FROM
            TRANSACTIONS
    ) AS F
GROUP BY
    MONTH,
    COUNTRY;