# ❄️ Snowflake Real-World Demo with Function Explanations

We’ll use a **Retail Sales database** (`CUSTOMERS`, `ORDERS`, `PRODUCTS`) to demonstrate each SQL concept.  

---

## **1. DDL (Data Definition Language)**
```sql
-- Create Database & Schema
CREATE OR REPLACE DATABASE RETAIL_DB;
CREATE OR REPLACE SCHEMA SALES;

-- Create Customers Table
CREATE OR REPLACE TABLE SALES.CUSTOMERS (
    CUSTOMER_ID INT AUTOINCREMENT,
    NAME STRING,
    EMAIL STRING,
    CITY STRING,
    CREATED_AT DATE
);
```
✅ **Explanation:**  
- `CREATE OR REPLACE` → creates a new object, replaces if already exists.  
- `AUTOINCREMENT` → auto-generates IDs.  
We are defining structure (DDL).  

---

## **2. DML (Data Manipulation Language)**
```sql
INSERT INTO SALES.CUSTOMERS (NAME, EMAIL, CITY, CREATED_AT)
VALUES ('Alice', 'alice@gmail.com', 'New York', '2024-01-15');
```
✅ **Explanation:**  
- `INSERT INTO` → adds rows into table.  
We use DML to insert actual business data.  

---

## **3. Joins**
```sql
SELECT O.ORDER_ID, C.NAME, P.PRODUCT_NAME, O.QUANTITY
FROM SALES.ORDERS O
JOIN SALES.CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN SALES.PRODUCTS P ON O.PRODUCT_ID = P.PRODUCT_ID;
```
✅ **Explanation:**  
- `JOIN` → combines rows from multiple tables based on keys.  
We join Orders with Customers & Products to see **full transaction details**.  

---

## **4. Filters**
```sql
SELECT O.ORDER_ID, C.NAME, P.PRODUCT_NAME
FROM SALES.ORDERS O
JOIN SALES.CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE C.CITY = 'New York';
```
✅ **Explanation:**  
- `WHERE` → filters rows based on condition.  
We only want orders placed by customers in **New York**.  

---

## **5. Subqueries**
```sql
SELECT NAME, EMAIL
FROM SALES.CUSTOMERS
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID 
    FROM SALES.ORDERS O
    JOIN SALES.PRODUCTS P ON O.PRODUCT_ID = P.PRODUCT_ID
    WHERE P.PRICE > 600
);
```
✅ **Explanation:**  
- `Subquery` → query inside another query.  
We use it to find **customers who bought expensive products (>600)**.  

---

## **6. GROUP BY**
```sql
SELECT P.PRODUCT_NAME, SUM(O.QUANTITY * P.PRICE) AS TOTAL_SALES
FROM SALES.ORDERS O
JOIN SALES.PRODUCTS P ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_NAME;
```
✅ **Explanation:**  
- `SUM()` → adds values.  
- `GROUP BY` → aggregates rows by column.  
This gives **total revenue per product**.  

---

## **7. ORDER BY**
```sql
SELECT NAME, CITY, CREATED_AT
FROM SALES.CUSTOMERS
ORDER BY CREATED_AT DESC;
```
✅ **Explanation:**  
- `ORDER BY` → sorts results.  
- `DESC` → newest first.  
We use it to list **latest customers first**.  

---

## **8. String Functions**
```sql
SELECT NAME, EMAIL, SPLIT_PART(EMAIL, '@', 2) AS DOMAIN
FROM SALES.CUSTOMERS;
```
✅ **Explanation:**  
- `SPLIT_PART(string, delimiter, position)` → splits a string.  
Here, we split email at `@` to extract **domain (gmail.com, yahoo.com)**.  

---

## **9. Date Functions**
```sql
SELECT ORDER_ID, ORDER_DATE, 
       DATEDIFF(DAY, ORDER_DATE, CURRENT_DATE) AS DAYS_AGO
FROM SALES.ORDERS;
```
✅ **Explanation:**  
- `DATEDIFF(unit, date1, date2)` → difference between dates.  
- `CURRENT_DATE` → today’s date.  
We find how many **days ago an order was placed**.  

---

## **10. Conversion Functions**
```sql
SELECT PRODUCT_NAME, TO_VARCHAR(PRICE) AS PRICE_TEXT
FROM SALES.PRODUCTS;
```
✅ **Explanation:**  
- `TO_VARCHAR()` → converts a value into text.  
We may convert prices into strings for **exporting to CSV** or reports.  

---

## **11. System Functions**
```sql
SELECT ORDER_ID, UNIFORM(1000,9999,RANDOM()) AS TRACKING_ID, CURRENT_TIMESTAMP
FROM SALES.ORDERS;
```
✅ **Explanation:**  
- `UNIFORM(min, max, random_seed)` → generates random number in range.  
- `RANDOM()` → seed function for randomness.  
- `CURRENT_TIMESTAMP` → system date-time.  
We use these to generate **unique tracking IDs** for shipments.  

---

## **12. Data Recovery & UNDROP**
```sql
DROP TABLE SALES.ORDERS;

-- Recover using UNDROP
UNDROP TABLE SALES.ORDERS;
```
✅ **Explanation:**  
- `UNDROP` → restores accidentally dropped object (within retention period).  
Helps in **business continuity**.  

---

## **13. Query History**
```sql
SELECT QUERY_ID, USER_NAME, EXECUTION_STATUS, START_TIME
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE DATABASE_NAME='RETAIL_DB'
ORDER BY START_TIME DESC;
```
✅ **Explanation:**  
- `QUERY_HISTORY` → system view storing query logs.  
We check **who ran queries and when**, useful for auditing.  

---

## **14. Cloning**
```sql
-- Clone entire database
CREATE OR REPLACE DATABASE RETAIL_DB_UAT CLONE RETAIL_DB;

-- Clone single table
CREATE OR REPLACE TABLE SALES.CUSTOMERS_CLONE CLONE SALES.CUSTOMERS;
```
✅ **Explanation:**  
- `CLONE` → creates zero-copy copy.  
We use it for **testing environments** without duplicating storage.  

---

# 🔑 Key Takeaways
- **Functions** (SPLIT_PART, DATEDIFF, TO_VARCHAR, UNIFORM, CURRENT_TIMESTAMP) → used for real business needs like parsing emails, calculating order age, converting formats, generating IDs.  
- **Admin features** (UNDROP, Query History, Cloning) → ensure reliability & auditing.  
