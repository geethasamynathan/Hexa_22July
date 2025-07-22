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
