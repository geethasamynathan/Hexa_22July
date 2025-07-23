
# 📘 Stored Procedures in SQL Server

## 🔍 What is a Stored Procedure?

A **Stored Procedure** is a precompiled group of one or more T-SQL statements stored as a database object that can be reused. It performs a specific task when invoked.

---

## 🔧 Creating a Stored Procedure

```sql
CREATE PROCEDURE spDisplayWelcome
AS
BEGIN
  PRINT 'WELCOME TO PROCEDURE in SQL Server'
END
```

### 🔁 Calling the Procedure

```sql
EXECUTE spDisplayWelcome
-- Or simply
spDisplayWelcome
```

> ⚠️ Avoid using `sp_` as a prefix for user-defined procedures to prevent conflicts with system procedures.

---

## 🧪 Example Table: Employee

```sql
CREATE TABLE Employee (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  DeptID INT
);

INSERT INTO Employee VALUES
(1, 'Geetha', 'Female', '1996-02-29', 1),
(2, 'Fransy', 'Female', '1995-05-25', 2),
(3, 'Gopi', 'Male', '1995-04-19', 2),
(4, 'BanuRekha', 'Female', '1996-03-17', 3),
(5, 'Shalini', 'Female', '1997-01-15', 1),
(6, 'Kalai', 'Female', '1995-07-12', 2),
(7, 'Santosh', 'Male', '1994-10-10', 1),
(8, 'Hariharan', 'Male', '1993-08-21', 2);
```

---

## 📥 Procedure to Get Employee Info

```sql
CREATE PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB FROM Employee
END

-- Execute
EXEC spGetEmployee
```

---

## 🧾 Viewing Procedure Text

```sql
sp_helptext spGetEmployee
```

---

## ✏️ Modify and Rename Procedure

```sql
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB FROM Employee ORDER BY Name
END

EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'
```

---

## ❌ Dropping a Procedure

```sql
DROP PROCEDURE spGetEmployee1
```

---

## 🧮 Input Parameters Example

```sql
ALTER PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  PRINT 'RESULT IS: ' + CAST(@Result AS VARCHAR)
END

-- Call the procedure
EXEC spAddTwoNumbers 10, 20
```

---

## 🎯 Procedure with Multiple Input Parameters

```sql
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
  @Gender VARCHAR(20),
  @DeptID INT
AS
BEGIN
  SELECT Name, Gender, DOB, DeptID 
  FROM Employee
  WHERE Gender = @Gender AND DeptID = @DeptID
END

-- Call with parameters
EXEC spGetEmployeesByGenderAndDepartment 'Male', 1
EXEC spGetEmployeesByGenderAndDepartment @DeptID=1, @Gender='Male'
```

---

## ✍️ Procedure to Update Employee

```sql
CREATE PROCEDURE spUpdateEmployeeByID
(
  @ID INT, 
  @Name VARCHAR(50), 
  @Gender VARCHAR(50), 
  @DOB DATETIME, 
  @DeptID INT
)
AS
BEGIN
  UPDATE Employee SET 
      Name = @Name, 
      Gender = @Gender,
      DOB = @DOB, 
      DeptID = @DeptID
  WHERE ID = @ID
END

-- Execute
EXEC spUpdateEmployeeByID 3, 'Palak', 'Female', '1994-06-17', 3
```

---

## 📤 Output Parameter Example

```sql
CREATE PROCEDURE spGetResult
  @No1 INT,
  @No2 INT,
  @Result INT OUTPUT
AS
BEGIN
  SET @Result = @No1 + @No2
END

-- Execute with OUTPUT
DECLARE @Result INT
EXEC spGetResult 10, 20, @Result OUTPUT
PRINT @Result
```

---

## 📊 Count Employees by Gender (Output Parameter)

```sql
CREATE PROCEDURE spGetEmployeeCountByGender
  @Gender VARCHAR(30),
  @EmployeeCount INT OUTPUT
AS
BEGIN
  SELECT @EmployeeCount = COUNT(ID)
  FROM Employee
  WHERE Gender = @Gender
END

DECLARE @EmployeeTotal INT
EXEC spGetEmployeeCountByGender 'Male', @EmployeeTotal OUTPUT
PRINT @EmployeeTotal
```

---

## 🧾 Stored Procedure with Default Parameters

```sql
CREATE PROCEDURE spAddNumber(@No1 INT=100, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @No1 + @No2
  PRINT 'The SUM of the 2 Numbers is: ' + CAST(@Result AS VARCHAR)
END

EXEC spAddNumber 3200, 25
EXEC spAddNumber @No2=25
```

---

## ✅ Advantages of Stored Procedures

- 🚀 **Performance**: Precompiled execution plans
- 🌐 **Reduces Network Traffic**: Only names + params sent
- 🔄 **Code Reusability**: Shared across apps
- 🔐 **Security**: Granular permissions, protect from SQL injection

---

## 📘 What is an Execution Plan?

An **execution plan** is SQL Server's optimized way to retrieve data based on indexes, joins, and query conditions. It defines the most efficient path to execute your query.

