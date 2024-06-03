-- https://leetcode.com/problems/triangle-judgement/submissions/1275858581/?envType=study-plan-v2&envId=top-sql-50

SELECT
    X,
    Y,
    Z,
    (
        CASE
            WHEN X + Y > Z AND X + Z > Y AND Y + Z > X THEN
                'Yes'
            ELSE
                'No'
        END ) AS TRIANGLE
FROM
    TRIANGLE;