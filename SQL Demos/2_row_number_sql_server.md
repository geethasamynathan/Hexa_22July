
# 📘 ROW_NUMBER Function in SQL Server

The `ROW_NUMBER()` function was introduced in **SQL Server 2005**. It is used to return a **sequential number starting from 1** for each row in the result set.

It is a **window function** that assigns a unique sequential integer to rows **within a partition** of a result set.

---

## 🔧 Syntax
```sql
ROW_NUMBER() OVER (
    [PARTITION BY value_expression]
    ORDER BY order_expression
)
```

- `PARTITION BY` is **optional**: It divides the result set into partitions and the numbering restarts from 1 for each partition.
- `ORDER BY` is **mandatory**: Defines the order of rows within each partition.

> ℹ️ If `PARTITION BY` is not specified, all rows are treated as a single partition.

---

## 🧪 Example Setup

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

## 🧮 ROW_NUMBER Without PARTITION BY

```sql
SELECT Name, Department, Salary,
       ROW_NUMBER() OVER (ORDER BY Department) AS RowNumber
FROM Employees;
```

- This assigns a unique row number across the entire result set, starting from 1.
- **All rows are treated as one partition.**

> ⚠️ If you omit the `ORDER BY` clause, you'll get an error:
> **“The function 'ROW_NUMBER' must have an OVER clause with ORDER BY.”**

---

## 🧮 ROW_NUMBER With PARTITION BY

```sql
SELECT Name, Department, Salary,
       ROW_NUMBER() OVER (
           PARTITION BY Department
           ORDER BY Name
       ) AS RowNumber
FROM Employees;
```

- Data is **partitioned by Department**.
- Within each partition, rows are **ordered by Name**.
- Row number **resets to 1** for each partition.

---

## 🌐 Real-Time Use Case: Removing Duplicates

### Step 1: Truncate and Insert Duplicate Records

```sql
TRUNCATE TABLE Employees;

INSERT INTO Employees VALUES
(1, 'James', 'IT', 15000),
(1, 'James', 'IT', 15000),
(2, 'Rasol', 'HR', 15000),
(2, 'Rasol', 'HR', 15000),
(2, 'Rasol', 'HR', 15000),
(3, 'Stokes', 'HR', 15000),
(3, 'Stokes', 'HR', 15000),
(3, 'Stokes', 'HR', 15000),
(3, 'Stokes', 'HR', 15000);
```

### Step 2: Delete Duplicates Using ROW_NUMBER

```sql
WITH DeleteDuplicateCTE AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
    FROM Employees
)
DELETE FROM DeleteDuplicateCTE WHERE RowNumber > 1;
```

- Partitions rows by `ID`
- Assigns row numbers in each partition
- Deletes all but the **first** row in each partition (i.e., keeps 1, removes duplicates)

---

## ✅ Summary

| Clause        | Description |
|---------------|-------------|
| `ROW_NUMBER()` | Returns a unique sequential number starting from 1 |
| `PARTITION BY` | Optional. Resets the row number for each partition |
| `ORDER BY`     | Required. Defines how the numbering should be done |

> `ROW_NUMBER()` is very useful for **pagination**, **duplicate removal**, and **ranking** scenarios.

