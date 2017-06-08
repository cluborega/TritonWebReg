-- MS4
--Alter or create
alter TRIGGER check_overlapping_meetings ON WEEKLYMEETING
INSTEAD OF INSERT AS
BEGIN
  DECLARE @meet_type VARCHAR(40)
  select @meet_type = meeting_type from inserted
  DECLARE @sec_id INT
  select @sec_id = sec_id from inserted
  DECLARE @day_meet VARCHAR(40)
  select @day_meet = days from inserted
  DECLARE @st_time TIME
  select @st_time = start_time from inserted

  SELECT wm.meeting_type, wc.days, wm.start_time, wm.end_time
  INTO #temp1
  FROM WEEKLYMEETING wm
    JOIN SECTION s ON wm.sec_id = s.id
    JOIN WEEKCONVERSION wc ON wc.SCHEDULE = wm.days
  WHERE s.id = @sec_id;

  SELECT @meet_type AS meetingType, wc.DAYS AS meetDays, @st_time as startTime, DATEADD(hh,1,@st_time) AS endTime INTO #temp2 FROM
    WEEKCONVERSION wc WHERE wc.SCHEDULE = @day_meet
  IF (
       SELECT COUNT(*) AS TOTAL FROM #temp1 AS T1
       WHERE EXISTS(
           SELECT * FROM #temp2 AS T2 WHERE
             T2.meetDays = T1.DAYS AND
             T2.startTime = T1.start_time
       )) > 0
    BEGIN
      RAISERROR ('A section at provided time already exists, please enter a different time',16,1);
      RETURN
    END