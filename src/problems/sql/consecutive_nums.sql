-- https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    DISTINCT(F.NUM) AS CONSECUTIVENUMS
FROM
    (
        SELECT
            I.ID,
            I.NUM,
            LAG(I.NUM, 1) OVER () AS LAG1,
            LAG(I.NUM, 2) OVER () AS LAG2
        FROM
            (
                SELECT
                    *
                FROM
                    LOGS
                ORDER BY
                    ID
            ) AS I
    ) F
WHERE
    F.NUM = F.LAG1
    AND F.NUM = F.LAG2;