-- https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50

WITH Q1 AS (
    SELECT
        F.NAME AS RESULTS --   COUNT(
 --     DISTINCT(F.movie_id)
 --   ) AS movies_rated
    FROM
        (
            SELECT
                R.MOVIE_ID AS MOVIE_ID,
                R.USER_ID AS USER_ID,
                R.RATING AS RATING,
                R.CREATED_AT AS CREATED_AT,
                U.NAME AS NAME
            FROM
                MOVIERATING R
                LEFT JOIN USERS U
                ON R.USER_ID = U.USER_ID
        ) AS F
    GROUP BY
        F.NAME
    ORDER BY
        COUNT( DISTINCT(F.MOVIE_ID) ) DESC,
        F.NAME ASC LIMIT 1
), Q2 AS (
    SELECT
 --   r.movie_id AS movie_id,
 --   AVG(r.rating) AS avg_rating,
        M.TITLE AS RESULTS
    FROM
        MOVIERATING R
        LEFT JOIN MOVIES M
        ON R.MOVIE_ID = M.MOVIE_ID
    WHERE
        MONTH(R.CREATED_AT) = 2
        AND YEAR(R.CREATED_AT) = 2020
    GROUP BY
        R.MOVIE_ID
    ORDER BY
        AVG(R.RATING) DESC,
        M.TITLE ASC LIMIT 1
)
SELECT
    RESULTS
FROM
    Q1
UNION
ALL (
    SELECT
        RESULTS
    FROM
        Q2
);