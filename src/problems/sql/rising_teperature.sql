-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50

# WRITE YOUR MYSQL QUERY STATEMENT BELOW

-- SELECT
--   id
-- FROM
--   (
--     SELECT
--       id,
--       recordDate,
--       temperature,
--       MAX(temperature) OVER(
--         ORDER BY
--           recordDate ROWS BETWEEN 1 PRECEDING
--           AND CURRENT ROW
--       ) AS max_temp,
--       COUNT(*) OVER(
--         ROWS BETWEEN 1 PRECEDING
--         AND CURRENT ROW
--       ) AS row_count
--     FROM
--       Weather
--   ) AS F
-- WHERE
--   F.temperature = F.max_temp
--   AND F.row_count = 2;
-- WITH
-- T1 AS (SELECT * FROM Weather),
-- T2 AS (SELECT DATE_SUB(recordDate, 1 INTERVAL DAY) FROM Weather)

WITH TODAY_TEMP_TABLE AS (
    SELECT
        ID,
        RECORDDATE,
        TEMPERATURE
    FROM
        WEATHER
), PREV_DAY_TEMP_TABLE AS (
    SELECT
        DATE_ADD(RECORDDATE, INTERVAL 1 DAY) AS PREV_RECORDDATE,
        TEMPERATURE                          AS PREV_TEMPERATURE
    FROM
        WEATHER
)
SELECT
    ID
FROM
    TODAY_TEMP_TABLE
    LEFT JOIN PREV_DAY_TEMP_TABLE
    ON TODAY_TEMP_TABLE.RECORDDATE = PREV_RECORDDATE
WHERE
    TEMPERATURE > PREV_TEMPERATURE;