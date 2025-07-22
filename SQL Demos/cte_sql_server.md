
# 📘 Common Table Expression (CTE) in SQL Server

## 🔍 What is a CTE?

A **CTE (Common Table Expression)** is a **temporary result set** in SQL Server that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement.

It is defined using the `WITH` keyword and exists only for the duration of the query execution.

---

## 🔧 Syntax

```sql
WITH CTE_Name (Optional_Column_List) AS (
    -- Query Definition
)
-- Use it like a table
SELECT * FROM CTE_Name;
```

---

## 🧪 Simple Example

```sql
WITH HighSalaryCTE AS (
    SELECT EmpID, EmpName, Salary
    FROM Employees
    WHERE Salary > 80000
)
SELECT * FROM HighSalaryCTE;
```

---

## 📍 When to Use CTE in SSMS

### ✅ 1. Simplifying Complex Queries

```sql
WITH DepartmentTotals AS (
    SELECT DeptID, COUNT(*) AS TotalEmployees
    FROM Employees
    GROUP BY DeptID
)
SELECT E.EmpName, D.TotalEmployees
FROM Employees E
JOIN DepartmentTotals D ON E.DeptID = D.DeptID;
```

---

### ✅ 2. Recursive Queries

```sql
WITH EmployeeHierarchy AS (
    SELECT EmpID, ManagerID, EmpName, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmpID, e.ManagerID, e.EmpName, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmpID
)
SELECT * FROM EmployeeHierarchy;
```

---

### ✅ 3. Reuse Logic in Multiple Queries

```sql
WITH HighEarners AS (
    SELECT * FROM Employees WHERE Salary > 80000
)
SELECT COUNT(*) FROM HighEarners;

SELECT AVG(Salary) FROM HighEarners;
```

---

### ✅ 4. DML Operations on Filtered Rows

```sql
WITH DuplicateFinder AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY EmpID ORDER BY EmpID) AS rn
    FROM Employees
)
DELETE FROM DuplicateFinder WHERE rn > 1;
```

---

## ⚖️ CTE vs Subquery vs Temp Table

| Feature             | CTE                          | Subquery                      | Temp Table                 |
|---------------------|------------------------------|-------------------------------|----------------------------|
| Readability         | ✅ High                       | ❌ Hard in complex logic       | ✅ High                    |
| Reusability         | ✅ Yes                        | ❌ No                          | ✅ Yes                    |
| Performance         | 🟡 Similar to subqueries      | 🟡 Same                        | ✅ Better for large data  |
| Use in recursion    | ✅ Yes                        | ❌ No                          | ❌ No                     |
| Lifetime            | Query-only                   | Query-only                    | Until session ends        |

---

## ✅ Benefits of Using CTE

- Cleaner and more readable SQL
- Allows recursion
- Avoids code duplication
- Supports DML with filtering logic

---

> 🔄 Use CTEs in **SSMS** whenever your query is becoming unreadable with subqueries or when you're doing hierarchical data traversal.
