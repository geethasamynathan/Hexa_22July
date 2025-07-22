
# 📘 RANK and DENSE_RANK Functions in SQL Server

## 🔧 RANK Function Overview

The `RANK()` function assigns a rank to each row in a result set. Like `ROW_NUMBER()`, it supports an optional `PARTITION BY` clause and a mandatory `ORDER BY` clause.

If there is a **tie**, the same rank is assigned, but **subsequent ranks are skipped**.

---

## 📌 Syntax

```sql
RANK() OVER (
    [PARTITION BY column]
    ORDER BY column
)
```

---

## 🧪 Example Table: Employees

```sql
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50), 
    Department VARCHAR(10),
    Salary INT
);
GO

INSERT INTO Employees VALUES
(1, 'James', 'IT', 80000),
(2, 'Taylor', 'IT', 80000),
(3, 'Pamela', 'HR', 50000),
(4, 'Sara', 'HR', 40000),
(5, 'David', 'IT', 35000),
(6, 'Smith', 'HR', 65000),
(7, 'Ben', 'HR', 65000),
(8, 'Stokes', 'IT', 45000),
(9, 'Taylor', 'IT', 70000),
(10, 'John', 'IT', 68000);
```

---

## 🧮 RANK Without PARTITION BY

```sql
SELECT Name, Department, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS [Rank]
FROM Employees;
```

- Treats the whole result set as one partition.
- Ranks are skipped in case of ties.

---

## 🧮 RANK With PARTITION BY

```sql
SELECT Name, Department, Salary,
       RANK() OVER (
           PARTITION BY Department
           ORDER BY Salary DESC
       ) AS [Rank]
FROM Employees;
```

- Ranks are assigned **per department**.
- Skips ranks for ties.

---

## 📘 DENSE_RANK Function Overview

The `DENSE_RANK()` function assigns a rank to each row like `RANK()` but **does not skip ranks** in the case of ties.

---

## 📌 Syntax

```sql
DENSE_RANK() OVER (
    [PARTITION BY column]
    ORDER BY column
)
```

---

## 🧮 DENSE_RANK Without PARTITION BY

```sql
SELECT Name, Department, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS [Rank]
FROM Employees;
```

- No skipped ranks even for ties.

---

## 🧮 DENSE_RANK With PARTITION BY

```sql
SELECT Name, Department, Salary,
       DENSE_RANK() OVER (
           PARTITION BY Department
           ORDER BY Salary DESC
       ) AS [DenseRank]
FROM Employees;
```

---

## 🔍 Difference: RANK vs DENSE_RANK

| Feature           | RANK()                      | DENSE_RANK()               |
|------------------|-----------------------------|----------------------------|
| Ties             | Same rank, skips next ranks | Same rank, no skipping     |
| Use Case         | When skipping is required   | When continuous ranking is needed |

---

## 💼 Real-Time Examples

### 🎯 1. Find 2nd Highest Salary Using RANK

```sql
WITH EmployeeCTE AS (
    SELECT Salary, RANK() OVER (ORDER BY Salary DESC) AS Rank_Salry
    FROM Employees
)
SELECT TOP 1 Salary FROM EmployeeCTE WHERE Rank_Salry = 2;
```

### 🎯 2. Find 2nd Highest Salary Using DENSE_RANK

```sql
WITH EmployeeCTE AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank_Salry
    FROM Employees
)
SELECT TOP 1 Salary FROM EmployeeCTE WHERE DenseRank_Salry = 2;
```

### 🎯 3. Find 3rd Highest Salary in IT Department

```sql
WITH EmployeeCTE AS (
    SELECT Salary, Department,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Salary_Rank
    FROM Employees
)
SELECT TOP 1 Salary 
FROM EmployeeCTE 
WHERE Salary_Rank = 3 AND Department = 'IT';
```

---

## 🧠 Summary

- Use `RANK()` when you want to **skip rankings** for ties.
- Use `DENSE_RANK()` when you want to **assign same rank for ties without skipping**.
- Both support **PARTITION BY** for group-wise ranking.

