-- https://leetcode.com/problems/employee-bonus/submissions/1276561298/?envType=study-plan-v2&envId=top-sql-50

SELECT
    R.NAME,
    L.BONUS
FROM
    (
        SELECT
            EMPID,
            BONUS
        FROM
            BONUS    B
        WHERE
            B.BONUS < 1000
        UNION
        SELECT
            EMPID,
            NULL    AS BONUS
        FROM
            EMPLOYEE
        WHERE
            EMPID NOT IN (
                SELECT
                    DISTINCT(EMPID) AS EMPID
                FROM
                    BONUS
            )
    )        L
    LEFT JOIN (
        SELECT
            EMPID,
            NAME
        FROM
            EMPLOYEE
    ) R
    ON L.EMPID = R.EMPID;