-- Stored Procedure without parameter
CREATE PROCEDURE usp_GetAllEmployees
AS
BEGIN 
SELECT * FROM Employees
END 


EXECUTE usp_GetAllEmployees
exec usp_GetAllEmployees
usp_GetAllEmployees

CREATE PROC usp_GetEmployeeInfo
AS
BEGIN
SELECT Id,Name,Department FROM Employees 
END

usp_GetEmployeeInfo

sp_helpText usp_GetEmployeeInfo


ALTER PROC usp_GetEmployeeInfo
AS
BEGIN
SELECT Name,DEpartment FROM Employees
END

DROP PROC usp_GetEmployeeInfo

usp_Getallemployees

--create stored procedure using input parameter


TRUNCATE TABLE EMPLOYEES

DROP TABLE EMPLOYEES
CREATE TABLE Employees (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  DeptID INT
);

INSERT INTO Employees VALUES
(1, 'Geetha', 'Female', '1996-02-29', 1),
(2, 'Fransy', 'Female', '1995-05-25', 2),
(3, 'Gopi', 'Male', '1995-04-19', 2),
(4, 'BanuRekha', 'Female', '1996-03-17', 3),
(5, 'Shalini', 'Female', '1997-01-15', 1),
(6, 'Kalai', 'Female', '1995-07-12', 2),
(7, 'Santosh', 'Male', '1994-10-10', 1),
(8, 'Hariharan', 'Male', '1993-08-21', 2);

CREATE PROC usp_GetEmployeesByDepartment
(@dept varchar(20))
AS
BEGIN
SELECT * FROM Employees  WHERE Department=@dept
END

exec usp_GetEmployeesByDepartment 'HR'


CREATE PROC usp_GetEmployeesByGenderAndDepartment
(@gender varchar(10),
@dept int)
AS
BEGIN
SELECT * FROM Employees  WHERE Gender=@gender and DeptID=@dept
END

usp_GetAllEmployees

Exec usp_GetEmployeesByGenderAndDepartment 'male',2

Exec usp_GetEmployeesByGenderAndDepartment @dept=1,@gender='Female'


-- stored procedure with output parameter

CREATE PROC spGetSum
(
@num1 int,
@num2 int,
@sum int OUTPUT)
AS
BEGIN
SET @sum=@num1+@num2
END

DECLARE @sumResult int
EXEC spGetSum 10,20,@sumResult OUT
print @sumResult

--Example Employees

ALTER PROC spGetEmplyeeCountByGender
(@gender varchar(10),
@empCount int OUT)
AS
BEGIN
SELECT @empCount=count(ID) FROM Employees WHERE Gender=@gender
END

DECLARE @empCount int
EXEC spGetEmplyeeCountByGender 'male',@empCount OUT
print @empCount

ALTER PROC spGetEmplyeeCountByGender1
(@femaleCount int OUT,@maleCount int OUT)
WITH RECOMPILE
AS
BEGIN
SELECT @femaleCount=COUNT(ID) FROM Employees WHERE Gender='female'
SELECT @maleCount=COUNT(ID) FROM Employees WHERE Gender='male'
END


DECLARE @femaleCount int,@maleCount int
EXEC spGetEmplyeeCountByGender1 @femaleCount OUT,@maleCount OUT
Print 'female : '+CAST(@femaleCount as varchar(10)) +'  Male :'+CAST(@maleCount as varchar(5))


sp_helptext  spGetEmplyeeCountByGender1



--Stored Procedure with default value
ALTER PROC spGetEmplyeeCountByGender
(@gender varchar(10)='male',
@empCount int OUT)
AS
BEGIN
SELECT @empCount=count(ID) FROM Employees WHERE Gender=@gender
END

DECLARE @count int
EXEC spGetEmplyeeCountByGender @empCount=@count OUT
print @count


DECLARE @count1 int
EXEC spGetEmplyeeCountByGender @gender='female', @empCount=@count1 OUT
print @count1