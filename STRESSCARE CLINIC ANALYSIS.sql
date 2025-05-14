--Create a new database called "StressCare" for this analysis
CREATE DATABASE StressCare


--Preview StressCeare daaset
SELECT*
FROM [dbo].[SQL CAPSTONE (Stress Level dataset)]


--Rename the dataset table name to "StressCare Data"
EXEC SP_RENAME '[dbo].[SQL CAPSTONE (Stress Level dataset)]', 'StressCare_Data'


--Preview dataset with new table name
SELECT *
FROM StressCare_Data


--Rename all column names
EXEC SP_RENAME 'StressCare_Data.id','Employee_ID';
EXEC SP_RENAME 'StressCare_Data.first_name','First_Name';
EXEC SP_RENAME 'StressCare_Data.Last_Name','Last_Name';
EXEC SP_RENAME 'StressCare_Data.gender','Gender';
EXEC SP_RENAME 'StressCare_Data.dob','Date_of_Birth';
EXEC SP_RENAME 'StressCare_Data.test_date','Test_Date';
EXEC SP_RENAME 'StressCare_Data.test_time','Test_Time';
EXEC SP_RENAME 'StressCare_Data.stress_source','Stress_Source';
EXEC SP_RENAME 'StressCare_Data.physical_symptoms','Physical_Symptoms';
EXEC SP_RENAME 'StressCare_Data.emotional_symptoms','Emotional_Symptoms';
EXEC SP_RENAME 'StressCare_Data.coping_mechanism','Coping_Mechanism';
EXEC SP_RENAME 'StressCare_Data.stress_duration','Stress_Duration';
EXEC SP_RENAME 'StressCare_Data.severity','Severity';
EXEC SP_RENAME 'StressCare_Data.sleep_quality','Sleep_Quality';
EXEC SP_RENAME 'StressCare_Data.mood','Mood';
EXEC SP_RENAME 'StressCare_Data.heart_rate','Heart_Rate';
EXEC SP_RENAME 'StressCare_Data.cortisol_level','Cortisol_Level';
EXEC SP_RENAME 'StressCare_Data.stress_level_score','Stress_Level_Score';


--Preview dataset with new column name
SELECT *
FROM StressCare_Data


--DATA CLEANING STEPS

--Check for repeated values across all columns
SELECT *,
ROW_NUMBER() OVER (PARTITION BY Employee_ID ORDER BY Employee_ID) AS Row_Numbers
FROM StressCare_Data

--Check for duplicates
WITH duplicates AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY Employee_ID ORDER BY Employee_ID) AS Row_Numbers
FROM StressCare_Data
)
SELECT*
FROM duplicates
WHERE Row_Numbers>1


-- Delete all 19 duplaicate rows

-- The query below is done for duplicates with NULL values (11 rows deleted)
SELECT *
FROM StressCare_Data
WHERE Employee_ID = 'UELA25'

DELETE FROM StressCare_Data
WHERE Employee_ID = 'UELA25' AND Test_Date IS NULL


-- Delete duplicates without NULL values (8 rows deleted)
WITH duplicates AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY Employee_ID ORDER BY Employee_ID) AS Row_Numbers
FROM StressCare_Data
)
DELETE duplicates
WHERE Row_Numbers>1


--Checking and handling of null values
SELECT *
FROM StressCare_Data
WHERE Mood IS NOT NULL

SELECT AVG(Stress_Level_Score)
FROM StressCare_Data

UPDATE StressCare_Data
SET Stress_Level_Score =(SELECT AVG(Stress_Level_Score)
FROM StressCare_Data
WHERE Stress_Level_Score IS NOT NULL)
WHERE Stress_Level_Score IS NULL


--Confirm the datatype of the date column
EXEC sp_help StressCare_Data


--Remove unecessary spaces from all columns

--Use Trim function to remove unwanted spaces in characers
UPDATE StressCare_Data
SET Mood = TRIM(Mood)

UPDATE StressCare_Data
SET Test_Date = LTRIM(RTRIM(Test_Date))
WHERE Test_Date <> LTRIM(RTRIM(Test_Date))


--Standardazing the date format

--Confirm the datatype of the date column
EXEC sp_help StressCare_Data


--Checking for outliers
SELECT *
FROM StressCare_Data
WHERE Date_of_Birth < '1900-01-01' OR  Date_of_Birth > GETDATE()


--Get the age column using Date of Birth
SELECT Employee_ID, Date_of_Birth, DATEDIFF(YEAR,Date_of_Birth,GETDATE())
FROM StressCare_Data
--Add a column called Age to the table
ALTER TABLE StressCare_Data
ADD Age INT
--Input Age values into the just created Age column
UPDATE StressCare_Data
SET Age = DATEDIFF(YEAR,Date_of_Birth,GETDATE())

--Get the average age of employees
SELECT AVG(Age) AS Average_Age
FROM StressCare_Data

--Get the minimum age of employees
SELECT MIN(Age) AS Minimum_Age
FROM StressCare_Data

--Get the maximum age of employees
SELECT MAX(Age) AS Maximum_Age
FROM StressCare_Data


--Create a new column name Age_Group
ALTER TABLE StressCare_Data
ADD Age_Group VARCHAR(20);

SELECT *
FROM StressCare_Data

--Classify the Age_Group column
UPDATE StressCare_Data
SET Age_Group= 
CASE
    WHEN AGE BETWEEN 19 and 29 THEN 'Young'
    WHEN AGE BETWEEN 30 and 49 THEN 'Adult'
    WHEN AGE BETWEEN 50 and 69 THEN 'Aged'
  ELSE 'Old'
END



--Classifying the Gender column
UPDATE StressCare_Data
SET Gender = 'Female'
WHERE Gender = 'F'

UPDATE StressCare_Data
SET Gender = 'Male'
WHERE Gender = 'M'



--Classifying the Stress_Level_Score column
--Round up to the nearest 2d.p
UPDATE StressCare_Data
SET Stress_Level_Score = ROUND(Stress_Level_Score, 2);


--Find the MIN and MAX value of Stress level score for grouping
SELECT MIN(Stress_Level_Score) AS Minimum_Stress_Score
FROM StressCare_Data
SELECT MAX(Stress_Level_Score) AS Maximum_Stress_Score
FROM StressCare_Data


--Create a new column name stress score group

SELECT *
FROM StressCare_Data

ALTER TABLE StressCare_Data
ADD Stress_Score_Group VARCHAR(20);

UPDATE StressCare_Data
SET Stress_Score_Group= 
CASE
WHEN Stress_Level_Score BETWEEN 0.67 and 1.05 THEN 'Low'
WHEN Stress_Level_Score BETWEEN 1.06 and 1.45 THEN 'Mild'
WHEN Stress_Level_Score BETWEEN 1.46 and 1.85 THEN 'High'
ELSE 'Very high'
END

--Create a new column name stress duration group

SELECT *
FROM StressCare_Data

--Get the average Stress_Level_Score
SELECT AVG(Stress_Duration)
FROM StressCare_Data

--Find the MIN and MAX value of Stress level score for grouping
SELECT MIN(Stress_Duration) AS Minimum_Stress_Duration
FROM StressCare_Data
SELECT MAX(Stress_Duration) AS Maximum_Stress_Duration
FROM StressCare_Data

ALTER TABLE StressCare_Data
ADD Stress_Duration_Group VARCHAR(20);


UPDATE StressCare_Data
SET Stress_Duration_Group = 
CASE
    WHEN Stress_Duration BETWEEN 7 AND 30 THEN 'Short Period'
    WHEN Stress_Duration BETWEEN 31 AND 90 THEN 'Average Period'
    WHEN Stress_Duration BETWEEN 91 AND 150 THEN 'Long Period'
    ELSE 'Extreme Period'
END;


--Create a new column name Heart rate group

SELECT *
FROM StressCare_Data

--Get the average Heart_Rate
SELECT AVG(Heart_Rate)
FROM StressCare_Data

--Find the MIN and MAX value of Stress level score for grouping
SELECT MIN(Heart_Rate) AS Minimum_Heart_Rate
FROM StressCare_Data;
SELECT MAX(Heart_Rate) AS Maximum_Heart_Rate
FROM StressCare_Data;

ALTER TABLE StressCare_Data
ADD Heart_Rate_Group VARCHAR(20);

UPDATE StressCare_Data
SET Heart_Rate_Group = 
CASE
    WHEN Heart_Rate BETWEEN 65 AND 74 THEN 'Very Healthy'
    WHEN Heart_Rate BETWEEN 75 AND 90 THEN 'Normal'
    WHEN Heart_Rate BETWEEN 91 AND 100 THEN 'Increased'
    ELSE 'High'
END;



--Create a new column name Cortisol Level group

SELECT *
FROM StressCare_Data

--Get the average Cortisol Level
SELECT AVG(Cortisol_Level) AS AVG_Cortisol_Level
FROM StressCare_Data

--Find the MIN and MAX value of Cortisol Level for grouping
SELECT MIN(Cortisol_Level) AS Minimum_Cortisol_Level
FROM StressCare_Data;
SELECT MAX(Cortisol_Level) AS Maximum_Cortisol_Level
FROM StressCare_Data;

ALTER TABLE StressCare_Data
ADD Cortisol_Level_Group VARCHAR(20);

UPDATE StressCare_Data
SET Cortisol_Level_Group = 
CASE
    WHEN Cortisol_Level BETWEEN 5 AND 9 THEN 'Very Healthy'
    WHEN Cortisol_Level BETWEEN 10 AND 14 THEN 'Normal'
    WHEN Cortisol_Level BETWEEN 15 AND 20 THEN 'High'
    ELSE 'Very High'
END;



--DATA ANALYSIS

--Retrieve Key Performance Indicators
--Retrieve the total number of employees in the dataset
SELECT COUNT(Employee_ID) AS No_of_Employees
FROM StressCare_Data

--Retrieve the avearge age of employees
SELECT AVG(Age) AS Average_Age
FROM StressCare_Data

--Calculate the Average Stress level score
SELECT AVG(Stress_Level_Score) AS Average_Stress_Level
FROM StressCare_Data

--Calculate the average stress duration in days
SELECT AVG(Stress_Duration) AS Stress_Duration
FROM StressCare_Data

--Calculate the average cortisol level
SELECT AVG(Cortisol_Level) AS Cortisol_Level
FROM StressCare_Data

--STRESS CARE ANALYSIS
--Analyze the severity of stress distribution
SELECT Severity, COUNT(Severity) AS Severity_Count,
CAST(COUNT(Severity) * 100.0 / SUM(COUNT(Severity)) OVER () AS DECIMAL(5,2)) AS Severity_Percentage
FROM StressCare_Data
GROUP BY Severity
ORDER BY Severity_Percentage DESC;

--Stress Source Distribution
SELECT Stress_Source, COUNT(Stress_Source) AS Strss_Source_Distribution
FROM StressCare_Data
GROUP BY Stress_Source
Order by Stress_Source ASC

--Physical Symptoms Distribution
SELECT Physical_Symptoms, COUNT(Physical_Symptoms) AS Physical_Symptoms_Distribution
FROM StressCare_Data
GROUP BY Physical_Symptoms
Order by Physical_Symptoms ASC

--Emotional Symptoms Distribution
SELECT Emotional_Symptoms, COUNT(Emotional_Symptoms) AS Emotional_Symptoms_Distribution
FROM StressCare_Data
GROUP BY Emotional_Symptoms
Order by Emotional_Symptoms ASC

--Cortisol Level Trend
SELECT FORMAT(Test_Date, 'MMM') AS Test_Date, AVG(Cortisol_Level) AS Avg_Cortisol_Level
FROM StressCare_Data
GROUP BY FORMAT(Test_Date, 'MMM')
ORDER BY  FORMAT(Test_Date, 'MMM') ASC

--Age group By Average stress score
SELECT Age_Group, AVG(Stress_Level_Score) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY Age_Group
ORDER BY Age_Group ASC

--Gender By Average Stress Score
SELECT Gender, AVG(Stress_Level_Score) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY Gender
ORDER BY Gender ASC

--Sleep Quality By Average Stress Score
SELECT Sleep_Quality, AVG(Stress_Level_Score) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY Sleep_Quality
ORDER BY Sleep_Quality ASC

--Test Time By Average Stress Score
SELECT FORMAT(Test_Time, 'h tt') AS Test_Hour, CAST(AVG(Stress_Level_Score) AS DECIMAL(4,2)) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY FORMAT(Test_Time, 'h tt'), DATEPART(HOUR, Test_Time)
ORDER BY DATEPART(HOUR, Test_Time) ASC

--Physical Symptoms By Average Stress Score
SELECT Physical_Symptoms, AVG(Stress_Level_Score) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY Physical_Symptoms
ORDER BY Physical_Symptoms DESC

--Emotional Symptoms By Average Stress Score
SELECT Emotional_Symptoms, AVG(Stress_Level_Score) AS Avg_Stress_Score
FROM StressCare_Data
GROUP BY Emotional_Symptoms
ORDER BY Emotional_Symptoms DESC

--Coping Mechanism By Stress Period
SELECT Coping_Mechanism, AVG(Stress_Duration) AS Avg_Stress_Period
FROM StressCare_Data
GROUP BY Coping_Mechanism
ORDER BY Coping_Mechanism ASC





























