
# 📘 Explanation of Snowflake Stream Example (INSERT)

## 🔹 1. Create Database and Base Tables
```sql
CREATE OR REPLACE TRANSIENT DATABASE STREAMS_DB;

create or replace table sales_raw_staging(
  id varchar,
  product varchar,
  price varchar,
  amount varchar,
  store_id varchar);

create or replace table store_table(
  store_id number,
  location varchar,
  employees number);

create or replace table sales_final_table(
  id int,
  product varchar,
  price number,
  amount int,
  store_id int,
  location varchar,
  employees int);
```
- **sales_raw_staging** → Staging table for incoming sales data  
- **store_table** → Dimension table with store details  
- **sales_final_table** → Target enriched table (sales + store info)  

---

## 🔹 2. Insert Initial Data
```sql
insert into sales_raw_staging values (...);
insert into store_table values (...);

INSERT INTO sales_final_table 
SELECT ... 
FROM SALES_RAW_STAGING SA
JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID;
```
- Populates initial data into staging & store tables  
- Loads enriched data into final table  

---

## 🔹 3. Create the Stream
```sql
create or replace stream sales_stream on table sales_raw_staging;
SHOW STREAMS;
DESC STREAM sales_stream;
```
- Creates a **stream** to track changes on `sales_raw_staging`  
- Verifies stream properties  

---

## 🔹 4. Querying Stream vs Base Table
```sql
select * from sales_stream;
select * from sales_raw_staging;
```
- **sales_raw_staging** → shows all rows  
- **sales_stream** → shows only changes since stream creation  

---

## 🔹 5. Insert New Data (Change Capture Begins)
```sql
insert into sales_raw_staging values
   (6,'Mango',1.99,1,2),
   (7,'Garlic',0.99,1,1);

select * from sales_stream;
```
- Inserts new rows  
- Stream reflects only these new inserts  

---

## 🔹 6. Consume the Stream into Final Table
```sql
INSERT INTO sales_final_table 
SELECT 
   SA.id, SA.product, SA.price, SA.amount,
   ST.STORE_ID, ST.LOCATION, ST.EMPLOYEES 
FROM SALES_STREAM SA
JOIN STORE_TABLE ST ON ST.STORE_ID=SA.STORE_ID;
```
- Consumes incremental changes (Mango, Garlic)  
- Loads them into final table with store info  
- After consumption, **stream is empty**  

---

## 🔹 7. Insert More Data + Consume Again
```sql
insert into sales_raw_staging values
   (8,'Paprika',4.99,1,2),
   (9,'Tomato',3.99,1,2);

INSERT INTO sales_final_table 
SELECT ... FROM SALES_STREAM SA
JOIN STORE_TABLE ST ...;
```
- New inserts captured in stream  
- Consumed again → only new rows loaded into final table  

---

## 🔹 8. Key Learning
- **Stream ≠ Full Table** → It is a log of changes  
- **Each query consumes offset** → once read, changes disappear  
- **Use streams for incremental ETL**  
- **Pair with Tasks** for scheduling  

---

# 📝 Summary
- **sales_raw_staging → sales_stream → sales_final_table**  
- Stream tracked only inserts after creation  
- Each load from stream consumed changes and enriched them with store info  
- Core CDC pattern in Snowflake  

