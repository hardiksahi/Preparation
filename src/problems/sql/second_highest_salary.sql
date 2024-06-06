-- https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    IFNULL( (
        SELECT
            SALARY AS SECONDHIGHESTSALARY
        FROM
            (
                SELECT
                    SALARY,
                    DENSE_RANK() OVER ( ORDER BY SALARY DESC ) AS RNK
                FROM
                    EMPLOYEE
            ) AS F
        WHERE
            F.RNK = 2 LIMIT 1
    ),
    NULL ) AS SECONDHIGHESTSALARY;