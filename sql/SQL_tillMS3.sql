DROP TABLE IF EXISTS #tempClassEnrolled;
-- Report- II part i and ii
IF OBJECT_ID('##tempClassEnrolled', 'U') IS NULL
  create table ##tempClassEnrolled  -- create temporry table to insert required data
  (
    stu_ssn int not null,
    class_id int not null,
    course_id int not null,
    section_num int not null,
    lec_day VARCHAR(10) not null,
    lec_time VARCHAR(10) not null,
    di_day VARCHAR(10),
    di_time VARCHAR(10)
  ) -- temp table helps compare the conflicting time with that of current classes
INSERT INTO ##tempClassEnrolled (stu_ssn, class_id, course_id, section_num, lec_day, lec_time, di_day, di_time)
  SELECT N.ssn AS ssn, C.id class_id, CU.id course_id, S.SECTION_NUM, S.LECT_DAYS, S.LECT_START_TIME, S.DI_DAYS, S.DI_STARTTIME
  FROM CLASS C, SECTION S, COURSE_WITHCLASS CWC, COURSE CU, SECTIONENROLLMENT E, STUDENT N
  WHERE N.SSN=16 AND N.STUDENT_ID = E.STUDENT_ID AND E.SECTION_ID = S.SECTION_NUM
        AND S.CLASS_ID = C.id AND C.id = CWC.CLASS_ID AND CU.id = CWC.COURSE_ID;

-- Finally query to display the computed results for par iu and ii of Report - II
SELECT C.CLASS_TITLE, CU.COURSENUMBER, S.SECTION_NUM, S.LECT_DAYS, S.LECT_START_TIME FROM CLASS C, COURSE_WITHCLASS CWC, COURSE CU, SECTION S, ##tempClassEnrolled ##tce
WHERE C.id = S.CLASS_ID AND S.CLASS_ID = CWC.CLASS_ID AND CWC.COURSE_ID = CU.id AND
      (##tce.lec_day = S.LECT_DAYS OR ##tce.di_day = S.DI_DAYS OR ##tce.lec_day = S.DI_DAYS OR ##tce.di_day = S.LECT_DAYS) AND
      (##tce.lec_time = S.LECT_START_TIME OR ##tce.di_time = S.DI_STARTTIME OR ##tce.lec_time = S.DI_STARTTIME OR ##tce.di_time = S.LECT_START_TIME)
GROUP BY S.SECTION_NUM,C.CLASS_TITLE,CU.COURSENUMBER, S.LECT_DAYS, S.LECT_START_TIME;

-- Displays all the classes student X is currenlty enrolled in
SELECT C.CLASS_TITLE, CU.COURSENUMBER, ##tCE.class_id FROM SECTION S
  LEFT JOIN CLASS C ON S.CLASS_ID = C.id
  LEFT JOIN COURSE_WITHCLASS CW ON C.id = CW.CLASS_ID
  LEFT JOIN COURSE CU ON CW.COURSE_ID = CU.id
  LEFT JOIN ##tempClassEnrolled ##tCE ON CU.id = ##tCE.course_id
GROUP BY CLASS_TITLE,COURSENUMBER, ##tCE.class_id;

-- REPROT III part i and ii)
SELECT COUNT(CASE WHEN grade_received = 'A+' THEN 1 END) AS 'A+',
       COUNT(CASE WHEN grade_received = 'A' THEN 1 END) AS "[A]",
       COUNT(CASE WHEN grade_received = 'A-' THEN 1 END) AS "A-",
       COUNT(CASE WHEN grade_received = 'B+' THEN 1 END) AS "B+",
       COUNT(CASE WHEN grade_received = 'B' THEN 1 END) AS "[B]",
       COUNT(CASE WHEN grade_received = 'B-' THEN 1 END) AS "B-",
       COUNT(CASE WHEN grade_received = 'C+' THEN 1 END) AS "C+",
       COUNT(CASE WHEN grade_received = 'C' THEN 1 END) AS "[C]",
       COUNT(CASE WHEN grade_received = 'C-' THEN 1 END) AS "C-",
       COUNT(CASE WHEN grade_received = 'D' THEN 1 END) AS "[D]",
       COUNT(CASE WHEN grade_received = 'F' THEN 1 END) AS "[F]"
FROM Course co
  JOIN COURSE_WITHCLASS ci ON co.id = ci.COURSE_ID
  JOIN Class cl ON ci.CLASS_ID = cl.id
  JOIN TEACHINGHISTORY th ON cl.id = th.class_id
  JOIN Quarter q ON cl.quarter = q.quarter AND cl.class_year = q.year
  -- JOIN Section s ON cl.id = s.class_id
  -- JOIN SectionEnrollment se ON s.id = se.section_id
  JOIN ClassesTaken ct ON cl.id = ct.CLASS_ID
WHERE co.id = ?
      AND q.id = ?;

-- Report-III part iii To get average GPA
SELECT SUM(number_grade)/COUNT(ct.id) AS avg_gpa
FROM COURSE co
  JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id
  JOIN CLASS cl ON ci.class_id = cl.id
  JOIN TEACHINGHISTORY th ON cl.id = th.class_id
  JOIN CLASSESTAKEN ct ON cl.id = ct.CLASS_ID
  JOIN GRADE_CONVERSION gc ON ct.grade_received = gc.letter_grade
WHERE (grade_received NOT IN ('IN', 'S', 'U') OR grade_received IS NULL)
      AND co.id = ?


SELECT COURSE.id AS Course, CLASS.CLASS_TITLE AS Class, s.SECTION_NUM AS SectionNum
FROM SECTION s;
JOIN Class cl ON s.class_id = cl.id
JOIN COURSE_WITHCLASS ci ON cl.id = ci.class_id
JOIN COURSE co ON ci.course_id = co.id
WHERE cl.quarter = '  CURRENT_QUARTER + "'
AND cl.class_year = '  CURRENT_YEAR + "'
ORDER BY Course, class_title, section_num;

SELECT co.COURSENUMBER AS courseNum, cl.CLASS_TITLE AS className, sec.SECTION_NUM AS SecNum
FROM SECTION sec
  JOIN CLASS cl ON sec.CLASS_ID = cl.id
  JOIN COURSE_WITHCLASS cwc ON cl.id = cwc.CLASS_ID
  JOIN COURSE co ON cwc.COURSE_ID = co.id
WHERE cl.QUARTER = 'SP'
      AND cl.CLASS_YEAR = '2017'
ORDER BY courseNum, className, SecNum


IF OBJECT_ID('CSE132B.dbo.#enrolled_section_times', 'U') IS NOT NULL DROP TABLE #enrolled_section_times;
DROP TABLE #enrolled_section_times
SELECT DISTINCT LECT_DAYS AS enrolled_days,
                STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), LECT_START_TIME, 0), 7), ' ', '0'), 6, 0, ' ') AS enrolled_start_time,
                STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), DATEADD(hh,1,LECT_START_TIME), 0), 7), ' ', '0'), 6, 0, ' ') AS enrolled_end_time
INTO #enrolled_section_times
FROM SECTION s
WHERE s.id IN (SELECT se.id FROM SECTIONENROLLMENT se)

SELECT * FROM #enrolled_section_times

-- IF OBJECT_ID('#tempDate','U') IS NOT NULL DROP TABLE #tempDate;
-- create table #tempDate (date_seq DATETIME2)
-- DECLARE @date_start DATE= '2017-04-04'--cast('2017-04-04' as DATE);
-- DECLARE @date_end DATE='2017-04-16' --cast('2017-04-16' as DATE);
-- BEGIN
-- while @date_start <= @date_end -- DATEADD(HH,25,@date_end)
--   INSERT INTO #tempDate(date_seq) VALUES (@date_start)
--     SET @date_start = DATEADD(DAY,1,@date_end)
-- END



SELECT DATENAME(MONTH,dt) AS month, DATEPART(DAY,dt) as DayNum, DATENAME(dw,dt) As Day, STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS Time


SELECT * FROM #available_times at, #enrolled_section_times et WHERE
  et.enrolled_days

IF OBJECT_ID('#tempDate','U') IS NOT NULL DROP TABLE #tempDate;
IF OBJECT_ID('#available_times','U') IS NOT NULL DROP TABLE #available_times;
declare @date_from datetime2, @date_to datetime2
set @date_from = '04/04/2017'
set @date_to = '04/05/2017';
with #tempDate as(
  select @date_from as dt
  union all
  select DATEADD(hh,1,dt) from #tempDate where dt<@date_to)
SELECT DATENAME(MONTH,dt) AS month, DATEPART(DAY,dt) as DayNum, DATENAME(dw,dt) As Day, STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS Time
INTO #available_times
FROM #tempDate;

SELECT *FROM #available_times






TRUNCATE TABLE QUARTER

-- Inserting quarters in the quarter table
DECLARE @cnt INT = 2007;

WHILE @cnt < 2020
  BEGIN
    INSERT INTO Quarter(quarter, year) VALUES ('WI', @cnt);
    INSERT INTO Quarter(quarter, year) VALUES ('SP', @cnt);
    INSERT INTO Quarter(quarter, year) VALUES ('SU', @cnt);
    INSERT INTO Quarter(quarter, year) VALUES ('FA', @cnt);
    SET @cnt = @cnt + 1;
  END;

-- CREATE TABLE MEETINGS(
--     id INT UNIQUE IDENTITY (1,1),
--     section_id INTEGER,
--     meeting_type VARCHAR(10),
--     start_time DATETIME2,
--     end_time DATETIME2,
--     location VARCHAR(10) NOT NULL,
--     required BIT NOT NULL,
--     PRIMARY KEY (section_id, meeting_type, start_time, end_time),
--     FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
-- );


---- **** PART 2 REPORT 2
SELECT DISTINCT st.SSN AS student_ssn, st.STUDENT_ID AS st_num, FIRSTNAME, MIDDLENAME, LASTNAME
FROM Student st
  JOIN SECTIONENROLLMENT se ON st.STUDENT_ID = se.STUDENT_ID
  JOIN SECTION s ON se.SECTION_ID = s.id
  JOIN CLASS c ON s.CLASS_ID = c.id
WHERE c.quarter = 'SP'
      AND c.class_year = '2017'
ORDER BY st.STUDENT_ID ASC;

DROP TABLE #tempClassEnrolled
SELECT co.COURSENUMBER AS courseEnrolled, cl.CLASS_TITLE AS classEnrolled, s.SECTION_NUM AS secEnrolled, m.start_time AS enrolledStartTime,
       m.end_time AS enrolledEndTime INTO #tempClassEnrolled
FROM COURSE co
  JOIN COURSE_WITHCLASS cwc ON co.id = cwc.COURSE_ID
  JOIN CLASS cl ON cwc.CLASS_ID = cl.id
  JOIN SECTION s ON cl.id = s.CLASS_ID
  JOIN SECTIONENROLLMENT se ON s.id = se.SECTION_ID
  JOIN STUDENT stu ON se.STUDENT_ID = stu.STUDENT_ID
  JOIN MEETINGS m ON s.id = m.section_id
                     AND cl.QUARTER = 'SP' AND cl.CLASS_YEAR = '2017'
WHERE stu.SSN = 21;

SELECT M.section_id, CL.CLASS_TITLE,COR.COURSENUMBER FROM #tempClassEnrolled TC
  JOIN MEETINGS M ON TC.enrolledStartTime = M.start_time AND
                     TC.enrolledEndTime = M.end_time AND
                     TC.secEnrolled <> M.section_id
  JOIN SECTIONENROLLMENT SE ON SE.SECTION_ID = M.section_id
  JOIN SECTION SC ON SE.SECTION_ID = SC.id
  JOIN CLASS CL ON CL.id = SC.CLASS_ID
  JOIN COURSE_WITHCLASS CWC ON CWC.CLASS_ID = CL.id
  JOIN COURSE COR ON CWC.COURSE_ID = COR.id
GROUP BY M.section_id, CL.CLASS_TITLE, COR.COURSENUMBER



--part3 final

CREATE TABLE WEEKCONVERSION(SCHEDULE VARCHAR(20), DAYS VARCHAR(10));

INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('MWF', 'Monday');
INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('MWF', 'Wednesday');
INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('MWF', 'Friday');
INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('TUETHU', 'Tuesday');
INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('TUETHU', 'Thursday');
INSERT INTO WEEKCONVERSION(SCHEDULE, DAYS) VALUES ('F', 'Friday');

DROP TABLE #enrolledStudentsInY

IF OBJECT_ID('#enrolledStudentsInY', 'U') IS NULL DROP TABLE #enrolledStudentsInY
SELECT st.STUDENT_ID INTO #enrolledStudentsInY FROM SECTION s
  JOIN SECTIONENROLLMENT se ON s.id = se.SECTION_ID
  JOIN STUDENT st ON se.STUDENT_ID = st.STUDENT_ID
WHERE s.id = 4

IF OBJECT_ID('#tempDate','U') IS NOT NULL DROP TABLE #tempDate;
IF OBJECT_ID('#available_times','U') IS NOT NULL DROP TABLE #available_times;
declare @date_from datetime2, @date_to datetime2
set @date_from = '04/04/2017'
set @date_to = '04/08/2017';
with #tempDate as(
  select @date_from as dt
  union all
  select DATEADD(hh,1,dt) from #tempDate where dt<@date_to)
SELECT * INTO #available_times FROM #tempDate


IF OBJECT_ID('#busyTime','U') IS NOT NULL DROP TABLE #busyTime;
SELECT m.start_time
INTO #busyTime FROM SECTION s
  JOIN SECTIONENROLLMENT se ON se.SECTION_ID = s.id
  JOIN #enrolledStudentsInY ey ON se.STUDENT_ID = ey.STUDENT_ID
  JOIN MEETINGS m ON m.section_id = s.id

SELECT DATENAME(month,att.dt) AS Month, DATEPART(DAY,att.dt) AS DayNum, DATENAME(dw,att.dt) AS DayName,
       STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS startTime,
       STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), DATEADD(hh,1,dt), 0), 7), ' ', '0'), 6, 0, ' ') AS endTime
FROM #available_times att
WHERE att.dt NOT IN (SELECT * FROM #busyTime) AND DATEPART(hh,att.dt) > 08 AND DATEPART(hh, att.dt) < 21



DATENAME(MONTH,dt) AS month, DATEPART(DAY,dt) as DayNum, DATENAME(dw,dt) As Day, STUFF(REPLACE(RIGHT(CONVERT(VarChar(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS Time


SELECT * FROM #available_times
-- SELECT dt AS Time
-- INTO #available_times
-- FROM #tempDate;

SELECT *FROM #available_times


IF OBJECT_ID('#available_times', 'U') IS NULL TRUNCATE TABLE #available_times;



-- SELECT wc.DAYS, s.LECT_START_TIME FROM SECTION s
-- JOIN SECTIONENROLLMENT se ON se.SECTION_ID = s.id
-- JOIN #enrolledStudentsInY ey ON se.STUDENT_ID = ey.STUDENT_ID
-- JOIN WEEKCONVERSION wc ON wc.SCHEDULE = s.LECT_DAYS
TRUNCATE TABLE TEACHINGHISTORY
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('JUSTIN BIEBER', 1);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('FLO RIDA', 43);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('SELENA GOMEZ', 3);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('TAYLOR SWIFT', 8);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('KELLY CLARKSON', 2);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('BJORK', 12);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('BJORK', 37);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('JUSTIN BIEBER', 17);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('KELLY CLARKSON', 23);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('ADAM LEVINE', 45);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('BJORK', 29);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('SELENA GOMEZ', 34);
INSERT INTO TeachingHistory(FACULTY, class_id) VALUES('BJORK', 11);