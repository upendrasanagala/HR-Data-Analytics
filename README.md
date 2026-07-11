# HR Analytics Dashboard & SQL Insights

This repository contains a comprehensive, end-to-end Human Resources (HR) Analytics project. It utilizes **Power BI** for interactive visual reporting and dashboarding, and **SQL** (MS SQL Server) for advanced data query analysis, exploring key employee metrics including demographics, performance, work modes, salary bands, and attrition.

---

## 📂 Project Structure

- **`HR Analytics.pbix`**: The core Power BI dashboard file, featuring interactive visuals, DAX measures, and drill-down reports.
- **`HR_Analytics_Final.csv`**: The dataset containing 5,000+ detailed employee records with demographic, financial, and organizational fields.
- **`SQLQuery.sql`**: A collection of structured SQL queries used to extract insights, perform aggregations, and run window functions.

---

## 📊 Dataset Profile

The dataset (`HR_Analytics_Final.csv`) consists of **5,000+ employee records** with 23 features, including:
- **Demographics**: `Gender`, `Age`, `AgeGroup`, `MaritalStatus`, `Education`, `State`.
- **Employment Details**: `Department`, `JobRole`, `JoiningDate`, `JoiningYear`, `Tenure` (Years), `Experience`, `ExperienceLevel`, `Manager`.
- **Performance & Behavior**: `PerformanceRating` (1-5 Scale), `Attrition` (Yes/No), `Overtime` (Yes/No), `WorkMode` (Office/Hybrid/Remote).
- **Financial Metrics**: `Salary`, `SalaryBand` (Low/Medium/High/Very High).

---

## 💻 SQL Analysis Highlights

The `SQLQuery.sql` file contains ready-to-run queries demonstrating data transformation and analytical queries on MS SQL Server. Below are some featured queries:

### 1. Overall Attrition Rate by Department
Calculates the total headcount, number of departed employees, and the attrition percentage across departments:
```sql
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
```

### 2. Top 3 Highest Paid Employees in Each Department
Uses Common Table Expressions (CTEs) and the `DENSE_RANK()` window function to identify top earners per department:
```sql
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
ORDER BY Department;
```

### 3. Employee Overtime vs. Attrition
Analyzes the correlation between overtime work and employee attrition:
```sql
SELECT Overtime,
       Attrition,
       COUNT(*) AS Employees
FROM Employees
GROUP BY Overtime, Attrition
ORDER BY Overtime;
```

---

## 📈 Power BI Dashboard Highlights

The interactive report (**`HR Analytics.pbix`**) is designed to answer critical organizational questions through visuals:

1. **KPI Scorecard**: Live tracking of Total Headcount, Attrition Rate, Average Salary, and Average Performance Rating.
2. **Demographics Breakdown**: Gender ratios and age distribution using tailored age bands (e.g., 21-30, 31-40).
3. **Attrition Drivers**: Visual comparisons of attrition by department, overtime status, and job satisfaction/performance ratings.
4. **Geographical Distribution**: Map visualizations showing headcount distribution across various states.
5. **Work Preference Analysis**: Analysis of hybrid vs. remote vs. in-office splits across departments.

---

## 🚀 How to Get Started

### Prerequisites
- **Power BI Desktop** (to open `.pbix` file).
- **MS SQL Server** / **SQL Server Management Studio (SSMS)** (or any preferred SQL compiler) to execute queries.

### Setting Up SQL Server
1. Create a database named `HR Analytics`.
2. Import the `HR_Analytics_Final.csv` dataset as a table named `Employees`.
3. Open `SQLQuery.sql` in SSMS and run queries against the database.
