use [HR Analytics]

-- changing the name of a table 
EXEC sp_rename 'HR_Analytics_Final', 'Employees';


SELECT * from Employees;


SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- employees by  department
select Department,
count(*) As EmployeeCount 
from employees
group by Department
order by employeeCount ASC;

-- Gender Distribiution
select Gender,
count(*) AS Total
from Employees
Group by Gender;

-- Avg Salary
SELECT AVG(CAST(Salary AS BIGINT)) AS AverageSalary   -- here bigint is while performing a arthemetic operation the number is execed to large number it shows overflow error so we use BIGINT
FROM Employees;

-- Highest Salary 
select TOP 10
EmployeeID,
FirstName,
LastName,
Salary
from employees
order by Salary Desc;

-- Salary by Department
SELECT Department,
       AVG(Salary) AS AvgSalary
FROM employees
GROUP BY Department
ORDER BY AvgSalary DESC;

-- Attrition Count 
SELECT Attrition,
       COUNT(*) AS Employees
FROM employees
GROUP BY Attrition;

-- employees by work mode
SELECT WorkMode,
       COUNT(*) AS Employees
FROM employees
GROUP BY WorkMode;

-- employees by state 
SELECT State,
       COUNT(*) AS Employees
FROM employees
GROUP BY State
ORDER BY Employees DESC;

-- Avg performance 
SELECT AVG(PerformanceRating) AS AvgPerformance
FROM employees;

-- Attrition rate by Department
SELECT Department,
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       ROUND(
           SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
           2
       ) AS AttritionRate
FROM Employees
GROUP BY Department
ORDER BY AttritionRate DESC;

-- Avg salary by department 
SELECT Department,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
ORDER BY AverageSalary DESC;

-- Salary Distribution by Job Role
SELECT JobRole,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY JobRole
ORDER BY AverageSalary DESC;

--Overtime vs Attrition

SELECT Overtime,
       Attrition,
       COUNT(*) AS Employees
FROM Employees
GROUP BY Overtime, Attrition
ORDER BY Overtime;

-- Hiring Trend 
SELECT YEAR(JoiningDate) AS JoiningYear,
       COUNT(*) AS EmployeesJoined
FROM Employees
GROUP BY YEAR(JoiningDate)
ORDER BY JoiningYear;

-- Avg performance by Department
SELECT Department,
       AVG(PerformanceRating) AS AvgPerformance
FROM Employees
GROUP BY Department
ORDER BY AvgPerformance DESC;

--Employees with More Than 10 Years Experience
-- SELECT Count(*) AS ExperiencedEmployees -- for total employees
select *
FROM Employees
WHERE Experience > 10;

-- Top 3 Highest Paid Employees in Each Department
WITH RankedEmployees AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY Department
               ORDER BY Salary DESC
           ) AS RankNo
    FROM Employees
)

SELECT *
FROM RankedEmployees
WHERE RankNo <= 3
order by Department;


--Salary Ranking

SELECT
EmployeeID,
FirstName,
Department,
Salary,
RANK() OVER
(
ORDER BY Salary DESC
) AS SalaryRank
FROM Employees;
