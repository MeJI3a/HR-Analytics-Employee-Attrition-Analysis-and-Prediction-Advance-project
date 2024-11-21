-- Simple Queires
-- 1. Total number of employees:
-- Find the total number of employees in the Employees table
SELECT COUNT(*) AS total_employees
FROM Employees;


-- 2. Number of employees for each department
SELECT d.DepartmentName, COUNT(*) AS employee_count
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


-- 3. Average age of employees
SELECT AVG(Age) AS average_age
FROM Employees;


-- 4. The number of male and female employees
SELECT Gender, COUNT(*) AS count
FROM Employees
GROUP BY Gender;


-- 5. Count the number of employees for each job role
SELECT j.JobRoleName, COUNT(*) AS employee_count
FROM Employees e
JOIN JobRoles j ON e.JobRoleID = j.JobRoleID
GROUP BY j.JobRoleName;


-- 6. Find departments with the highest average monthly income
SELECT d.DepartmentName, AVG(e.MonthlyIncome) AS avg_monthly_income
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY avg_monthly_income DESC;


-- 7. Percentage of employees who have left (Attrition = true)
SELECT 
    (SUM(CASE WHEN Attrition THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS attrition_rate
FROM Employees;


-- 8. Number of employees by education level
SELECT Education, COUNT(*) AS count
FROM Employees
GROUP BY Education;


-- 9. Number of employees based on marital status
SELECT m.MaritalStatusName, COUNT(*) AS employee_count
FROM Employees e
JOIN MaritalStatuses m ON e.MaritalStatusID = m.MaritalStatusID
GROUP BY m.MaritalStatusName;


-- 10. Employees work overtime
SELECT OverTime, COUNT(*) AS count
FROM Employees
GROUP BY OverTime;


-- Complex Queries

-- 1. Find the percentage contribution of each department to the total monthly income
SELECT 
    d.DepartmentName,
    SUM(e.MonthlyIncome) AS total_monthly_income,
    ROUND(
        (SUM(e.MonthlyIncome) * 100.0) / (SELECT SUM(MonthlyIncome) FROM Employees), 2
    ) AS income_percentage
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY income_percentage DESC;



-- 2. Analyze income distribution and percentage growth by job level
SELECT 
    JobLevel,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income,
    AVG(MonthlyIncome) AS avg_income,
    ROUND(
        (AVG(MonthlyIncome) - LAG(AVG(MonthlyIncome)) OVER (ORDER BY JobLevel)) 
        / NULLIF(LAG(AVG(MonthlyIncome)) OVER (ORDER BY JobLevel), 0) * 100, 2
    ) AS income_growth_percentage
FROM Employees
GROUP BY JobLevel
ORDER BY JobLevel;


-- 3. Calculate attrition rate for each department and compare it with the company-wide attrition rate
WITH CompanyAttrition AS (
    SELECT 
        (SUM(CASE WHEN Attrition THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS company_attrition_rate
    FROM Employees
)
SELECT 
    d.DepartmentName,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN e.Attrition THEN 1 ELSE 0 END) AS attrited_employees,
    ROUND(
        (SUM(CASE WHEN e.Attrition THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2
    ) AS department_attrition_rate,
    ROUND(
        (
            ROUND((SUM(CASE WHEN e.Attrition THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2)
            - (SELECT company_attrition_rate FROM CompanyAttrition)
        ), 2
    ) AS attrition_difference
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY department_attrition_rate DESC;



-- 4. Find job roles with the attrition count and attrition rate
SELECT 
    j.JobRoleName,
    COUNT(*) AS total_employees, -- Total number of employees in the role
    SUM(CASE WHEN e.Attrition = true THEN 1 ELSE 0 END) AS attrition_count, -- Employees who left
    ROUND(
        (SUM(CASE WHEN e.Attrition = true THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2
    ) AS attrition_rate -- Attrition percentage for the role
FROM Employees e
JOIN JobRoles j ON e.JobRoleID = j.JobRoleID
GROUP BY j.JobRoleName
ORDER BY attrition_rate DESC; -- Sort by attrition rate


-- 5. Average monthly income by education level with comparison to company-wide average
WITH AvgIncomeByEducation AS (
    SELECT 
        Education,
        AVG(MonthlyIncome) AS avg_monthly_income,
        ROUND(AVG(MonthlyIncome) - (SELECT AVG(MonthlyIncome) FROM Employees), 2) AS diff_from_company_avg
    FROM Employees
    GROUP BY Education
)
SELECT *
FROM AvgIncomeByEducation
ORDER BY Education;


-- 6. Employees satisfaction analysis by department with rankings
WITH SatisfactionByDepartment AS (
    SELECT 
        d.DepartmentName,
        ROUND(AVG(e.JobSatisfaction), 2) AS avg_job_satisfaction,
        ROUND(AVG(e.EnvironmentSatisfaction), 2) AS avg_env_satisfaction,
        RANK() OVER (ORDER BY AVG(e.JobSatisfaction) DESC) AS satisfaction_rank
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)
SELECT *
FROM SatisfactionByDepartment
ORDER BY satisfaction_rank;


-- 7. Average total working years by job role with max and min comparison
WITH AvgWorkingYearsByRole AS (
    SELECT 
        j.JobRoleName,
        ROUND(AVG(e.TotalWorkingYears), 2) AS avg_working_years,
        MAX(e.TotalWorkingYears) AS max_working_years,
        MIN(e.TotalWorkingYears) AS min_working_years
    FROM Employees e
    JOIN JobRoles j ON e.JobRoleID = j.JobRoleID
    GROUP BY j.JobRoleName
)
SELECT *
FROM AvgWorkingYearsByRole
ORDER BY avg_working_years DESC;


-- 8. Gender distribution by department with percentage
WITH GenderDistributionByDept AS (
    SELECT 
        d.DepartmentName,
        e.Gender,
        COUNT(*) AS employee_count,
        ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY d.DepartmentName), 2) AS gender_percentage
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName, e.Gender
)
SELECT *
FROM GenderDistributionByDept
ORDER BY DepartmentName, Gender;


-- 9. Performance ratings by job role and job level with deviation analysis
WITH PerformanceByRoleAndLevel AS (
    SELECT 
        j.JobRoleName,
        e.JobLevel,
        ROUND(AVG(e.PerformanceRating), 2) AS avg_performance,
        ROUND(STDDEV(e.PerformanceRating), 2) AS performance_deviation
    FROM Employees e
    JOIN JobRoles j ON e.JobRoleID = j.JobRoleID
    GROUP BY j.JobRoleName, e.JobLevel
)
SELECT *
FROM PerformanceByRoleAndLevel
ORDER BY avg_performance DESC;


-- 10. Top performers in each department with their total working years
WITH TopPerformersByDepartment AS (
    SELECT 
        d.DepartmentName,
        e.EmpID,
        e.PerformanceRating,
        e.TotalWorkingYears
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE e.PerformanceRating = (
        SELECT MAX(e2.PerformanceRating) 
        FROM Employees e2 
        WHERE e2.DepartmentID = e.DepartmentID
    )
)
SELECT *
FROM TopPerformersByDepartment
ORDER BY DepartmentName;


















