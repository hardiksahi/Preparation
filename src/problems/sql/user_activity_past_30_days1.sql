-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/?envType=study-plan-v2&envId=top-sql-50

SELECT
    ACTIVITY_DATE              AS DAY,
    COUNT( DISTINCT(USER_ID) ) AS ACTIVE_USERS
FROM
    ACTIVITY
GROUP BY
    ACTIVITY_DATE
HAVING
    ACTIVITY_DATE BETWEEN DATE_SUB( '2019-07-27', INTERVAL 29 DAY ) AND '2019-07-27';