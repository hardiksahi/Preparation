-- https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

WITH ALL_SUBJECTS_TABLE AS (
    SELECT
        *
    FROM
        STUDENTS
        CROSS JOIN SUBJECTS
)
SELECT
    L.STUDENT_ID,
    L.STUDENT_NAME,
    L.SUBJECT_NAME,
    COALESCE(R.ATTENDED_EXAMS,
    0) AS ATTENDED_EXAMS
FROM
    ALL_SUBJECTS_TABLE AS L
    LEFT JOIN (
        SELECT
            STUDENT_ID,
            SUBJECT_NAME,
            COUNT(*) AS ATTENDED_EXAMS
        FROM
            EXAMINATIONS
        GROUP BY
            STUDENT_ID,
            SUBJECT_NAME
    ) AS R
    ON L.STUDENT_ID = R.STUDENT_ID
    AND L.SUBJECT_NAME = R.SUBJECT_NAME
ORDER BY
    L.STUDENT_ID,
    L.SUBJECT_NAME;