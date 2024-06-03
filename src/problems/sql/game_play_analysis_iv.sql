-- 550. Game Play Analysis IV : https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    ROUND( COUNT( DISTINCT(F.PLAYER_ID) )/ (
        SELECT
            COUNT( DISTINCT(PLAYER_ID) )
        FROM
            ACTIVITY
    ), 2 ) AS FRACTION
FROM
    (
        SELECT
            PLAYER_ID,
            EVENT_DATE,
            LEAD(EVENT_DATE) OVER( PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC ) AS NEXT_LOGIN_EVENT_DATE,
            RANK() OVER ( PARTITION BY PLAYER_ID ORDER BY EVENT_DATE )              AS RNK
        FROM
            ACTIVITY
    ) AS F
WHERE
    DATEDIFF( F.NEXT_LOGIN_EVENT_DATE, F.EVENT_DATE ) = 1
    AND F.RNK = 1;