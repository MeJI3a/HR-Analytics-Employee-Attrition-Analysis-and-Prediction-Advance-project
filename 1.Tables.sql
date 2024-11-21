CREATE TEMP TABLE temp_hr_analytics (
    EmpID VARCHAR(50),
    Age INT,
    AgeGroup VARCHAR(50),
    Attrition BOOLEAN,
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender CHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    SalarySlab VARCHAR(50),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime BOOLEAN,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager FLOAT
);

DROP TABLE IF EXISTS temp_hr_analytics;

COPY temp_hr_analytics (
    EmpID, Age, AgeGroup, Attrition, BusinessTravel, DailyRate, Department, 
    DistanceFromHome, Education, EducationField, EmployeeNumber, 
    EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, 
    JobLevel, JobRole, JobSatisfaction, MaritalStatus, MonthlyIncome, 
    SalarySlab, MonthlyRate, NumCompaniesWorked, OverTime, 
    PercentSalaryHike, PerformanceRating, RelationshipSatisfaction, 
    StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, 
    WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, 
    YearsSinceLastPromotion, YearsWithCurrManager
)
FROM 'C:\\Program Files\\PostgreSQL\\15\\data\\Cleaned_HR_Analytics.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) AS row_count
FROM temp_hr_analytics;

SELECT *
FROM temp_hr_analytics
WHERE 1=1;

------------------------------------------------------------------------------
-- Departments table
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(50) UNIQUE
);

-- Education table
CREATE TABLE EducationFields (
    EducationFieldID SERIAL PRIMARY KEY,
    EducationFieldName VARCHAR(100) UNIQUE
);

-- Job role table
CREATE TABLE JobRoles (
    JobRoleID SERIAL PRIMARY KEY,
    JobRoleName VARCHAR(100) UNIQUE
);

-- Marital status table
CREATE TABLE MaritalStatuses (
    MaritalStatusID SERIAL PRIMARY KEY,
    MaritalStatusName VARCHAR(50) UNIQUE
);

-- Business travel table
CREATE TABLE BusinessTravels (
    BusinessTravelID SERIAL PRIMARY KEY,
    BusinessTravelName VARCHAR(50) UNIQUE
);

----------------------------------------------------

-- Employess table

CREATE TABLE Employees (
    EmpID VARCHAR(50) PRIMARY KEY,
    Age INT,
    AgeGroup VARCHAR(50),
    Attrition BOOLEAN,
    DailyRate INT,
    DistanceFromHome INT,
    Education INT,
    EducationFieldID INT REFERENCES EducationFields(EducationFieldID),
    EmployeeNumber INT UNIQUE,
    EnvironmentSatisfaction INT,
    Gender CHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRoleID INT REFERENCES JobRoles(JobRoleID),
    JobSatisfaction INT,
    MaritalStatusID INT REFERENCES MaritalStatuses(MaritalStatusID),
    MonthlyIncome INT,
    SalarySlab VARCHAR(50),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    OverTime BOOLEAN,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager FLOAT,
    DepartmentID INT REFERENCES Departments(DepartmentID),
    BusinessTravelID INT REFERENCES BusinessTravels(BusinessTravelID)
);

------------------------------------------------------------------------
-- department
INSERT INTO Departments (DepartmentName)
SELECT DISTINCT Department
FROM temp_hr_analytics;

-- Education
INSERT INTO EducationFields (EducationFieldName)
SELECT DISTINCT EducationField
FROM temp_hr_analytics;

-- Job role
INSERT INTO JobRoles (JobRoleName)
SELECT DISTINCT JobRole
FROM temp_hr_analytics;

-- Marital status
INSERT INTO MaritalStatuses (MaritalStatusName)
SELECT DISTINCT MaritalStatus
FROM temp_hr_analytics;

-- Business travel
INSERT INTO BusinessTravels (BusinessTravelName)
SELECT DISTINCT BusinessTravel
FROM temp_hr_analytics;

----------------------------------------------------------------------------------
INSERT INTO Employees (
    EmpID, Age, AgeGroup, Attrition, DailyRate, DistanceFromHome, Education,
    EducationFieldID, EmployeeNumber, EnvironmentSatisfaction, Gender,
    HourlyRate, JobInvolvement, JobLevel, JobRoleID, JobSatisfaction,
    MaritalStatusID, MonthlyIncome, SalarySlab, MonthlyRate, NumCompaniesWorked,
    OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction,
    StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance,
    YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager,
    DepartmentID, BusinessTravelID
)
SELECT 
    EmpID, Age, AgeGroup, Attrition, DailyRate, DistanceFromHome, Education,
    (SELECT EducationFieldID FROM EducationFields WHERE EducationFieldName = t.EducationField),
    EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel,
    (SELECT JobRoleID FROM JobRoles WHERE JobRoleName = t.JobRole),
    JobSatisfaction,
    (SELECT MaritalStatusID FROM MaritalStatuses WHERE MaritalStatusName = t.MaritalStatus),
    MonthlyIncome, SalarySlab, MonthlyRate, NumCompaniesWorked, OverTime, PercentSalaryHike,
    PerformanceRating, RelationshipSatisfaction, StockOptionLevel, TotalWorkingYears,
    TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole,
    YearsSinceLastPromotion, YearsWithCurrManager,
    (SELECT DepartmentID FROM Departments WHERE DepartmentName = t.Department),
    (SELECT BusinessTravelID FROM BusinessTravels WHERE BusinessTravelName = t.BusinessTravel)
FROM temp_hr_analytics t
ON CONFLICT (EmpID) DO NOTHING;

SELECT COUNT(*) FROM Employees;

SELECT e.EmpID, e.Age, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
LIMIT 10;




