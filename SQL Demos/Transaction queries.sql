--Create Product table
CREATE TABLE Product
(
ProductID INT PRIMARY KEY, 
Name VARCHAR(40), 
Price INT,
Quantity INT
)
GO
-- Populate Product Table with test data
INSERT INTO Product VALUES(101, 'Product-1', 100, 10)
INSERT INTO Product VALUES(102, 'Product-2', 200, 15)
INSERT INTO Product VALUES(103, 'Product-3', 300, 20)
INSERT INTO Product VALUES(104, 'Product-4', 400, 25)



BEGIN TRANSACTION
INSERT INTO Product VALUES(105,'Product-5',500, 30)
UPDATE Product SET Price =350 WHERE ProductID = 103
DELETE FROM Product WHERE ProductID = 103
COMMIT TRANSACTION






BEGIN TRANSACTION
 BEGIN TRY
	INSERT INTO Product VALUES(106,'Product-6',600,12)
	INSERT INTO Product VALUES(106,'Product-6',600,12)
	DELETE FROM Product where ProductID=102
	COMMIT TRANSACTION
	END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

SELECT * FROM Product


--Implicit transaction Mode
SET IMPLICIT_TRANSACTIONS ON

CREATE TABLE Customer
(
CustomerId int primary key,
CustomerCode varchar(10),
CustomerName varchar(50)
)

insert into Customer values(1,'ccode-1','John')
insert into Customer values(1,'ccode-2','James')

Delete from customer
Select * from Customer

SET IMPLICIT_TRANSACTIONS ON
insert into Customer values(1,'ccode-1','John')
insert into Customer values(2,'ccode-2','James')

COMMIT Transaction
Select * from Customer

insert into Customer values(3,'ccode-3','Peter')
Update Customer set CustomerName='Riya' where CustomerId=1
Rollback Transaction
Select * from Customer