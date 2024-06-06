-- https://leetcode.com/problems/delete-duplicate-emails/?envType=study-plan-v2&envId=top-sql-50

DELETE FROM PERSON
WHERE
    ID NOT IN (
        SELECT
            ID
        FROM
            (
                SELECT
                    ID,
                    EMAIL,
                    DENSE_RANK() OVER ( PARTITION BY EMAIL ORDER BY ID ASC ) AS RNK
                FROM
                    PERSON
            ) F
        WHERE
            F.RNK = 1
    );