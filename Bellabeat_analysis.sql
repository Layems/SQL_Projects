-- Previewing my data

SELECT * FROM Capstone..dailyActivity_merged$;
--940 rows

SELECT * FROM Capstone..sleepDay_merged$;
--413 rows

SELECT * FROM Capstone..weightLogInfo_merged$;
--67 rows

-- Checking for distinct users

SELECT DISTINCT Id FROM capstone..dailyActivity_merged$;
--33 rows

SELECT DISTINCT Id FROM Capstone..sleepDay_merged$;
---- 24 rows

SELECT DISTINCT Id FROM Capstone..weightLogInfo_merged$;
-- 8 rows

SELECT * FROM Capstone..dailyActivity_merged$
	WHERE TotalSteps != 0;
--863 rows

	
-- view Id's whose sleep was recorded
SELECT d.Id, d.Date, d.Day_of_week, d.TotalSteps, d.SedentaryMinutes, d.Calories, s.TotalMinutesAsleep
	FROM Capstone..dailyActivity_merged$ d
	FULL OUTER JOIN Capstone..sleepDay_merged$ s ON
	d.Id = s.Id AND d.Date = s.Date 
	WHERE s.TotalMinutesAsleep IS NOT NULL;
		
-- Count number of logins daily

SELECT Day_of_week, COUNT(*) AS No_of_login
	FROM Capstone..dailyActivity_merged$
	WHERE TotalSteps != 0
	GROUP BY Day_of_week;

-- Average daily steps and sleep

SELECT d.Day_of_week, ROUND(AVG(d.TotalSteps), 2) AS Average_num_of_steps, ROUND(AVG(s.TotalMinutesAsleep/60), 2) AS Average_SleepTime
	FROM Capstone..dailyActivity_merged$ d
	JOIN Capstone..sleepDay_merged$ s
	ON d.Id = s.Id
	GROUP BY Day_of_week;


-- create view

CREATE VIEW avg_num_steps_sleep AS
	SELECT d.Day_of_week, ROUND(AVG(d.TotalSteps), 2) AS Average_num_of_steps, ROUND(AVG(s.TotalMinutesAsleep/60), 2) AS Average_SleepTime
	FROM Capstone..dailyActivity_merged$ d
	JOIN Capstone..sleepDay_merged$ s
	ON d.Id = s.Id
	GROUP BY Day_of_week;

SELECT * FROM avg_num_steps_sleep;