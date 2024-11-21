SELECT 
    e.EmpID,
    e.Age,
    e.AgeGroup,
    e.Attrition,
    e.DailyRate,
    e.DistanceFromHome,
    e.Education,
    ef.EducationFieldName AS EducationField,
    e.EmployeeNumber,
    e.EnvironmentSatisfaction,
    e.Gender,
    e.HourlyRate,
    e.JobInvolvement,
    e.JobLevel,
    jr.JobRoleName AS JobRole,
    e.JobSatisfaction,
    ms.MaritalStatusName AS MaritalStatus,
    e.MonthlyIncome,
    e.SalarySlab,
    e.MonthlyRate,
    e.NumCompaniesWorked,
    e.OverTime,
    e.PercentSalaryHike,
    e.PerformanceRating,
    e.RelationshipSatisfaction,
    e.StockOptionLevel,
    e.TotalWorkingYears,
    e.TrainingTimesLastYear,
    e.WorkLifeBalance,
    e.YearsAtCompany,
    e.YearsInCurrentRole,
    e.YearsSinceLastPromotion,
    e.YearsWithCurrManager,
    d.DepartmentName AS Department,
    bt.BusinessTravelName AS BusinessTravel
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN EducationFields ef ON e.EducationFieldID = ef.EducationFieldID
LEFT JOIN JobRoles jr ON e.JobRoleID = jr.JobRoleID
LEFT JOIN MaritalStatuses ms ON e.MaritalStatusID = ms.MaritalStatusID
LEFT JOIN BusinessTravels bt ON e.BusinessTravelID = bt.BusinessTravelID;
