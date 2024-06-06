-- https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    IFNULL( (
        SELECT
            NUM
        FROM
            MYNUMBERS
        GROUP BY
            NUM
        HAVING
            COUNT(*) = 1
        ORDER BY
            NUM DESC LIMIT 1
    ),
    NULL ) AS NUM;