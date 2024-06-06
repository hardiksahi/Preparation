-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/?envType=study-plan-v2&envId=top-sql-50

SELECT
    L.EMPLOYEE_ID,
    R.NAME,
    L.REPORTS_COUNT,
    L.AVERAGE_AGE
FROM
    (
        SELECT
            REPORTS_TO                     AS EMPLOYEE_ID,
            COUNT( DISTINCT(EMPLOYEE_ID) ) AS REPORTS_COUNT,
            ROUND( AVG(AGE), 0 )           AS AVERAGE_AGE
        FROM
            EMPLOYEES
        WHERE
            REPORTS_TO IS NOT NULL
        GROUP BY
            REPORTS_TO
    )         AS L
    LEFT JOIN EMPLOYEES R
    ON L.EMPLOYEE_ID = R.EMPLOYEE_ID;