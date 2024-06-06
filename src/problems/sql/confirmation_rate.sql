-- https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

WITH T1 AS (
    SELECT
        USER_ID,
        COUNT(*) AS TOTAL_REQUESTS
    FROM
        CONFIRMATIONS
    GROUP BY
        USER_ID
), T2 AS (
    SELECT
        USER_ID,
        ACTION,
        COUNT(*) AS TOTAL_ACTION_REQUESTS
    FROM
        CONFIRMATIONS
    GROUP BY
        USER_ID,
        ACTION
)
SELECT
    SIGNUPS.USER_ID AS USER_ID,
    COALESCE(Q.CONFIRMATION_RATE,
    0) AS CONFIRMATION_RATE
FROM
    SIGNUPS
    LEFT JOIN (
        SELECT
            F.USER_ID AS USER_ID,
            ROUND( F.TOTAL_ACTION_REQUESTS / F.TOTAL_REQUESTS,
            2 ) AS CONFIRMATION_RATE
        FROM
            (
                SELECT
                    T2.USER_ID,
                    T2.ACTION,
                    T2.TOTAL_ACTION_REQUESTS,
                    T1.TOTAL_REQUESTS
                FROM
                    T2
                    INNER JOIN T1
                    ON T2.USER_ID = T1.USER_ID
                WHERE
                    T2.ACTION = 'confirmed'
            ) AS F
    ) AS Q
    ON SIGNUPS.USER_ID = Q.USER_ID;