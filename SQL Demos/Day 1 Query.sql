CREATE TABLE Department
(
ID INT PRIMARY KEY,
Name VARCHAR(50)
)
GO
-- Populate the Department Table with test data
INSERT INTO Department VALUES(1, 'IT')
INSERT INTO Department VALUES(2, 'HR')
INSERT INTO Department VALUES(3, 'Sales')

Drop table Employee
-- Create Employee Table
CREATE TABLE Employee
(
ID INT PRIMARY KEY,
Name VARCHAR(50),
Gender VARCHAR(50),
DOB DATETIME,
DeptID INT
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


select * from dbo.Department

select * from dbo.Employee


CREATE VIEW vwGetAllEmployees
AS
SELECT * FROM Employee


-- Exceute the View
SELECT * FROM vwGetAllEmployees

CREATE VIEW vwGetFemaleEmployees
AS
SELECT * FROM Employee where Gender='Female'

SELECT * from vwGetFemaleEmployees


--DML 

INSERT INTO vwGetAllEmployees (ID,Name,Gender,DOB,DeptID)
VALUES (7,'Santhosh','Male','1-2-2000',1)

UPDATE vwGetAllEmployees SET Name='Santhosh M' where Id=7

DELETE FROM vwGetAllEmployees where Id=1

--Complex view Example
 --complex view from multiple table
CREATE VIEW vwAllEmployeeWithDepartment
AS
SELECT e.Id,e.Name,e.Gender,e.DOB,d.Name as DepartmentName
from Employee e
join Department d
on e.DeptID=d.ID

select * from vwAllEmployeeWithDepartment

insert into vwAllEmployeeWithDepartment (Id,Name,Gender,DOB,DepartmentName)
values (8,'HemaLatha','Female','2-2-2000','Admin')  -- ERRor
--complex view from single table

CREATE VIEW vwEmployeeCountByGender
AS
select Gender,Count(*) as TotalEmployee
FROM Employee Group by Gender


select * from vwEmployeeCountByGender

insert into vwEmployeeCountByGender (Gender,TotalEmployee)
values
('others',3)


Select * from Employee
select * from Department

CREATE VIEW vwHREmployees
AS
select * from Employee where DeptID=2

select * from vwHREmployees

insert into vwHREmployees (Id,Name,Gender,DOB,DeptID)
values (8,'Roshini','Female','3-3-2000',1)


ALTER VIEW vwHREmployees
AS
select * from Employee where DeptID=2
WITH CHECK OPTION


sp_helptext vwHREmployees

ALTER VIEW vwHREmployees
WITH ENCRYPTION
AS
select * from Employee where DeptID=2
WITH CHECK OPTION




--create view based on Another View

CREATE VIEW vwITEmployees
AS
SELECT Id,Name,DOB,Gender,DeptID from 
vwGetAllEmployees where DeptId=1


select * from vwITEmployees

-- CTE ==>


Drop table Employee
Create Table Employees
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50), 
    Department VARCHAR(10),
    Salary INT,
)
Go

Insert Into Employees Values (1, 'James', 'IT', 80000)
Insert Into Employees Values (2, 'Taylor', 'IT', 80000)
Insert Into Employees Values (3, 'Pamela', 'HR', 50000)
Insert Into Employees Values (4, 'Sara', 'HR', 40000)
Insert Into Employees Values (5, 'David', 'IT', 35000)
Insert Into Employees Values (6, 'Smith', 'HR', 65000)
Insert Into Employees Values (7, 'Ben', 'HR', 65000)
Insert Into Employees Values (8, 'Stokes', 'IT', 45000)
Insert Into Employees Values (9, 'Taylor', 'IT', 70000)
Insert Into Employees Values (10, 'John', 'IT', 68000)
Go

select * from Employees

--CTE

WITH HighSalaryCTE AS(
SELECT Id,Name,Department,Salary 
FROM Employees
WHERE Salary>=80000
)

SELECT * FROM HighSalaryCTE



select * from Employees



SELECT Name,Salary,E.Department,
d.TotalEmployees,
d.TotalSalary,
d.MinSalary,
d.MaxSalary,
d.AverageSalary
FROM employees e
INNER Join(
SELECT Department,
count(*)  as TotalEmployees,
sum(salary) as TotalSalary,
min(salary) as MinSalary,
Max(salary) as MaxSalary,
Avg(Salary) as AverageSalary
FROM Employees 
Group BY Department)
d on d.Department=e.Department



-- same result using Over Clause

SELECT Name,Salary,Department,
count(department) OVER(PARTITION BY Department) as DepartmentTotals,
SUM(Salary) OVER(PARTITION BY Department) as TotalSalary,
Min(Salary) OVER(PARTITION BY Department) as MinSalary,
Max(Salary) OVER(PARTITION BY Department) as MaxSalary,
Avg(Salary) OVER(PARTITION BY Department) as Averagesalry
FROM Employees


truncate table employees
select * from Employees
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

SELECT Id,Name,Department,Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Name)
AS RowNumber From Employees

SELECT Id,Name,Department,Salary,
ROW_NUMBER() OVER(ORDER BY Name)
AS RowNumber From Employees


Drop table Employees

CREATE TABLE [dbo].[Employees](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Department] [varchar](10) NULL,
	[Salary] [int] NULL,
	)
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

Select * from Employees


WITH DeleteDuplicateCTE AS
(
select *,ROW_NUMBER() OVER (PARTITION BY ID ORDER BY ID)
AS RowNumber from EMployees)


DELETE FROM DeleteDuplicateCTE Where RowNumber > 1


SELECT * FROM Employees
TRUNCATE TABLE Employees

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
SELECT Name,Department,Salary,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY SALARY desc) AS [Rank]
FROM Employees

WITH EmployeeCTE AS (
    SELECT Salary, RANK() OVER (ORDER BY Salary DESC) AS Rank_Salry
    FROM Employees
)
SELECT TOP 1 Salary FROM EmployeeCTE WHERE Rank_Salry = 2;

WITH EmployeeCTE AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank_Salry
    FROM Employees
)
SELECT TOP 1 Salary FROM EmployeeCTE WHERE DenseRank_Salry = 2;

WITH EmployeeCTE AS (
    SELECT Salary, Department,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Salary_Rank
    FROM Employees
)
SELECT TOP 1 Salary 
FROM EmployeeCTE 
WHERE Salary_Rank = 3 AND Department = 'IT';

--Assignment
/*Create a Product Catalog View with Price
The Marketing Team needs a view of Active Products(model_year> 2018)
along with the brand,category and price

View neds to show the product_id,Product_name,brand_name,category_name,list_price
display the view using order by category_name,product_Name

*/

/*
The inventory team wants to identify products that haven't been sold. Create a view listing all products that have zero sales.
*/
/*
The inventory team wants to identify products that haven't been sold. Create a view listing all products that have zero sales.
Write a query that:

Ranks products within each category by list price (highest first)

Returns only the first product per category

Expected Output:
category_name, product_name, list_price — only one row per category
*/
