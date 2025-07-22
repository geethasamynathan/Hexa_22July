
# 📘 OVER Clause in SQL Server

The `OVER` clause in SQL Server is used with `PARTITION BY` to break up the data into **partitions**.

### 🔧 Syntax:
```sql
<AggregateFunction>(<Column>) OVER (PARTITION BY <PartitionColumn>)
```

### 🧠 Concept:
The specified function operates **within each partition**. For example, if we have departments like HR, IT, and Payroll, then:

```sql
COUNT(Department) OVER (PARTITION BY Department)
```

This partitions the data by `Department`, and applies the `COUNT()` function within each department.

You can use a wide range of built-in functions like:
- `COUNT()`
- `SUM()`
- `MAX()`
- `MIN()`
- `AVG()`
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`

---

## 🗃️ Example Table: Employees

Use the following SQL script to create and populate the `Employees` table:

```sql
CREATE TABLE Employees (
    ID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);
GO

INSERT INTO Employees VALUES
(1, 'James', 'IT', 15000),
(2, 'Smith', 'IT', 35000),
(3, 'Rasol', 'HR', 15000),
(4, 'Rakesh', 'Payroll', 35000),
(5, 'Pam', 'IT', 42000),
(6, 'Stokes', 'HR', 15000),
(7, 'Taylor', 'HR', 67000),
(8, 'Preety', 'Payroll', 67000),
(9, 'Priyanka', 'Payroll', 55000),
(10, 'Anurag', 'Payroll', 15000),
(11, 'Marshal', 'HR', 55000),
(12, 'David', 'IT', 96000);
```

---

## 🧾 Requirement:
Generate a report to show:
- Total employees per department
- Total salary
- Average salary
- Minimum salary
- Maximum salary

---

## ✅ Using `GROUP BY` Clause

```sql
SELECT Department, 
       COUNT(*) AS NoOfEmployees, 
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary,
       MIN(Salary) AS MinSalary, 
       MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY Department;
```

This works **fine** for aggregate-only reports.

---

## ❌ Problem:
What if we want to **include `Name` and `Salary` (non-aggregated columns)** in the same report?

### ❌ Attempt (Invalid):

```sql
SELECT Name, Salary, Department, 
       COUNT(*) AS NoOfEmployees, 
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary,
       MIN(Salary) AS MinSalary, 
       MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY Department;
```

This gives an error:
> Column 'Name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

---

## ✅ Solution 1: Using Subquery + JOIN

```sql
SELECT Name, Salary, E.Department, 
       D.DepartmentTotals,
       D.TotalSalary, 
       D.AvgSalary, 
       D.MinSalary, 
       D.MaxSalary   
FROM Employees E
INNER JOIN (
    SELECT Department, 
           COUNT(*) AS DepartmentTotals,
           SUM(Salary) AS TotalSalary,
           AVG(Salary) AS AvgSalary,
           MIN(Salary) AS MinSalary, 
           MAX(Salary) AS MaxSalary
    FROM Employees
    GROUP BY Department
) D ON E.Department = D.Department;
```

### ✅ Output:
Includes both individual data and department-level aggregates.

---

## ✅ Solution 2: Use `OVER` Clause with `PARTITION BY`

```sql
SELECT Name, 
       Salary, 
       Department,
       COUNT(Department) OVER(PARTITION BY Department) AS DepartmentTotals,
       SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary,
       AVG(Salary) OVER(PARTITION BY Department) AS AvgSalary,
       MIN(Salary) OVER(PARTITION BY Department) AS MinSalary,
       MAX(Salary) OVER(PARTITION BY Department) AS MaxSalary
FROM Employees;
```

### ✅ Output:
Each row contains:
- The employee's name and salary
- Department-wise aggregated metrics (without needing GROUP BY or JOINs)

---

## 🧠 Summary

| Clause         | Purpose                                  | Allows non-aggregated columns |
|----------------|-------------------------------------------|-------------------------------|
| `GROUP BY`     | Groups data and aggregates per group      | ❌ No                         |
| `OVER(PARTITION BY)` | Aggregates while preserving row-level data | ✅ Yes                        |
