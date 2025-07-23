--User Defined Function

--Scalar Valued Function

CREATE FUNCTION SVF1(@num INT)
RETURNS INT
AS
BEGIN
RETURN @num*@nuM*@num
END


SELECT dbo.SVF1(3)

Select * from Employees

ALTER FUNCTION FN_GetEmployeeByDeptID
(@deptid int)
RETURNS TABLE
AS
RETURN (SELECT * from Employees where DeptID=@deptid)


SELECT * FROM dbo.FN_GetEmployeeByDeptID(2)

DROP TABLE Department
CREATE TABLE Department
(
ID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
)
GO
-- Populate the Department Table with test data
INSERT INTO Department VALUES(1, 'IT')
INSERT INTO Department VALUES(2, 'HR')
INSERT INTO Department VALUES(3, 'Sales')
GO

DROP TABLE EMPLOYEE
-- Create Employee Table
CREATE TABLE Employee
(
ID INT PRIMARY KEY,
Name VARCHAR(50),
Gender VARCHAR(50),
DOB DATETIME,
DeptID INT FOREIGN KEY REFERENCES Department(ID) 
)
GO
-- Populate the Employee Table with test data
INSERT INTO Employee VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO Employee VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO Employee VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO Employee VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
INSERT INTO Employee VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO Employee VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)
GO


CREATE FUNCTION FN_GetEMployeesByGender
(
@gender varchar(20)
)
RETURNS TABLE
AS
RETURN (SELECT * from EMployee where Gender=@gender)

SELECT * FROM dbo.FN_GetEMployeesByGender('male')


SELECT Name,Gender,DOB,DepartmentName FROM FN_GetEMployeesByGender('Male') emp
JOIN Department dept on dept.ID=emp.DeptID



--Example for return data from Multiple table using table valued function

CREATE FUNCTION FN_EmployeesByGender
(@gender varchar(50))
RETURNS TABLE
AS
RETURN (SELECT Name,Gender,DOB,DepartmentName FROM Employee emp
JOIN Department dept on dept.ID=emp.DeptID
WHERE Gender=@gender)

SELECT * FROM DBO.FN_EmployeesByGender('FEMALE')

--Example for Multi-statement table Valued function
CREATE FUNCTION FN_MultiStatement()
RETURNS @Mytable Table (Id int,Name varchar(40))
AS
BEGIN
INSERT INTO @Mytable
SELECT ID,Name from Employee
return
END


SELECT * FROM FN_MultiStatement()