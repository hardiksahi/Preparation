-- https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50

-- Way 1: With subquery (slow)
-- WITH T1 AS (
--   SELECT
--     DISTINCT(employee_id)
--   FROM
--     Employees
-- )
-- SELECT
--   employee_id
-- FROM
--   Employees
-- WHERE
--   salary < 30000
--   AND manager_id IS NOT NULL
--   AND manager_id NOT IN (
--     SELECT
--       *
--     FROM
--       T1
--   )
-- ORDER BY
--   employee_id ASC;

-- Way2: Without sub query using LEFT JOIN
SELECT
    T3.EMPLOYEE_ID
FROM
    (
        SELECT
            T1.EMPLOYEE_ID AS EMPLOYEE_ID,
            T1.MANAGER_ID  AS MANAGER_ID,
            T2.NAME        AS MANAGER_NAME
        FROM
            (
                SELECT
                    EMPLOYEE_ID,
                    MANAGER_ID
                FROM
                    EMPLOYEES
                WHERE
                    SALARY < 30000
                    AND MANAGER_ID IS NOT NULL
            ) T1
            LEFT JOIN (
                SELECT
                    EMPLOYEE_ID,
                    NAME
                FROM
                    EMPLOYEES
            ) T2
            ON T1.MANAGER_ID = T2.EMPLOYEE_ID
    ) T3
WHERE
    T3.MANAGER_NAME IS NULL
ORDER BY
    T3.EMPLOYEE_ID;