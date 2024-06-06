-- https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    Z.ID,
    Z.STUDENT
FROM
    (
        SELECT
            (
                CASE
                    WHEN F.USE_NEW_ID = 1 THEN
                        F.NEW_ID
                    ELSE
                        ID
                END ) AS ID,
            F.STUDENT
        FROM
            (
                SELECT
                    ID,
                    STUDENT,
                    (
                        CASE
                            WHEN ID % 2 = 0 THEN
                                ID - 1
                            ELSE
                                ID + 1
                        END ) AS NEW_ID,
                    (
                        CASE
                            WHEN ID = (
                                SELECT
                                    MAX(ID)
                                FROM
                                    SEAT
                            ) AND (
                                SELECT
                                    COUNT(*)
                                FROM
                                    SEAT
                            )% 2 != 0 THEN
                                0
                            ELSE
                                1
                        END ) AS USE_NEW_ID
                FROM
                    SEAT
            ) AS F
    ) AS Z
ORDER BY
    ID ASC;