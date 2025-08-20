# ❄️ Snowflake Recap Questions & Answers

This document contains **definition-based** and **scenario-based** recap questions on Snowflake key topics.  

---

## 1. Snowflake Architecture
**Q1. Definition-based:**  
What is the basic architecture of Snowflake and how does it differ from traditional databases?  
**A1.** Snowflake uses a **multi-cluster shared data architecture**, separating Storage, Compute, and Cloud Services layers. Unlike traditional systems, storage and compute scale independently.

**Q2. Scenario-based:**  
Your organization experiences performance issues during peak hours. Which Snowflake architectural feature helps overcome this?  
**A2.** Use **multi-cluster warehouses** to automatically add clusters when query demand spikes.

---

## 2. Warehouse
**Q3. Definition-based:**  
What is a Virtual Warehouse in Snowflake?  
**A3.** A compute resource used to run queries, load, and transform data. Warehouses can be paused/resumed and scaled.

**Q4. Scenario-based:**  
A Data Scientist’s heavy ML queries slow down reporting queries. What’s the solution?  
**A4.** Create **separate warehouses** for Data Science and Reporting to isolate workloads.

---

## 3. Database & Schema
**Q5. Definition-based:**  
What is the difference between a Database and a Schema in Snowflake?  
**A5.**  
- Database = top-level container of schemas  
- Schema = logical grouping of objects inside a database  

**Q6. Scenario-based:**  
Your company wants HR and Finance data in the same account but separate. What’s the design?  
**A6.** Create one database (`COMPANY_DB`) with schemas (`HR_SCHEMA`, `FIN_SCHEMA`).  

---

## 4. Stage & Types
**Q7. Definition-based:**  
What is a stage in Snowflake and what are its types?  
**A7.** A stage is a temporary storage location for files before load/unload. Types:  
- User stage (@~)  
- Table stage (@%table)  
- Named internal stage  
- External stage (S3, Azure Blob, GCS)

**Q8. Scenario-based:**  
You need to load CSV files from Azure Blob Storage. Which stage type?  
**A8.** Create an **external stage** pointing to the Blob container.

---

## 5. Finding Column Count
**Q9. Definition-based:**  
How can you find the number of columns in a Snowflake table?  
**A9.**  
```sql
SELECT COUNT(*) 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'ORDERS';
```

**Q10. Scenario-based:**  
How to quickly check column details of CUSTOMERS table?  
**A10.** Use:  
```sql
DESC TABLE CUSTOMERS;
```

---

## 6. Loading Data With Stage
**Q11. Definition-based:**  
What is the process of loading data into Snowflake using a stage?  
**A11.** Upload file → Define file format → `COPY INTO` table.

**Q12. Scenario-based:**  
You uploaded `orders.csv` into @%orders stage. How do you load it?  
**A12.**  
```sql
COPY INTO ORDERS
FROM @%orders/orders.csv
FILE_FORMAT = (TYPE=CSV SKIP_HEADER=1);
```

---

## 7. Loading Data Without Stage
**Q13. Definition-based:**  
Can you load data without a stage?  
**A13.** Yes, using `PUT` command in SnowSQL or connectors (Python, Spark, etc.).

**Q14. Scenario-based:**  
A user uploads a local CSV directly. Which command is used?  
**A14.**  
```bash
PUT file://orders.csv @%orders;
COPY INTO ORDERS FROM @%orders;
```

---

## 8. Transforming Data
**Q15. Definition-based:**  
How can Snowflake transform data while loading?  
**A15.** Use `COPY INTO` with transformations in SELECT.  

**Q16. Scenario-based:**  
While loading, you want all customer names in uppercase. How?  
**A16.**  
```sql
COPY INTO CUSTOMERS
FROM (SELECT $1, UPPER($2), $3 FROM @stg_customers)
FILE_FORMAT = (TYPE=CSV);
```

---

## 9. COPY INTO
**Q17. Definition-based:**  
What is the purpose of COPY INTO?  
**A17.** Loads data into tables or unloads data from tables into stage.  

**Q18. Scenario-based:**  
Unload sales data to S3. Which command?  
**A18.**  
```sql
COPY INTO @my_s3_stage/sales_data/
FROM SALES
FILE_FORMAT = (TYPE=CSV);
```

---

## 10. Rejected Records
**Q19. Definition-based:**  
What are rejected records?  
**A19.** Records failing load due to type mismatch, bad data, or parsing errors.  

**Q20. Scenario-based:**  
How to review rejected rows from orders.csv?  
**A20.** Use:  
```sql
COPY INTO ORDERS
FROM @stg_orders
FILE_FORMAT=(TYPE=CSV)
VALIDATION_MODE=RETURN_ERRORS;
```

---

## 11. ON_ERROR
**Q21. Definition-based:**  
What are ON_ERROR options?  
**A21.**  
- `ABORT_STATEMENT` (stop load)  
- `CONTINUE` (skip bad rows)  
- `SKIP_FILE` (skip entire file)  
- `SKIP_FILE_NUM` (skip after X errors)  

**Q22. Scenario-based:**  
You want valid rows loaded but bad rows skipped. Which option?  
**A22.** `ON_ERROR=CONTINUE`

---

## 12. Scaling Up/Down
**Q23. Definition-based:**  
Difference between scaling up vs scaling out?  
**A23.**  
- Scaling Up = increase warehouse size  
- Scaling Out = add clusters (multi-cluster warehouse)  

**Q24. Scenario-based:**  
A single long-running query is slow. What to do?  
**A24.** Scale **up**.  

**Q25. Scenario-based:**  
Hundreds of users running reports simultaneously. What to do?  
**A25.** Scale **out** (multi-cluster warehouse).

---

## 13. FORCE
**Q26. Definition-based:**  
What does FORCE=TRUE in COPY INTO do?  
**A26.** Forces reloading of files already marked as loaded.  

**Q27. Scenario-based:**  
You truncated a table and want to reload the same staged files. How?  
**A27.**  
```sql
COPY INTO ORDERS
FROM @stg_orders
FILE_FORMAT=(TYPE=CSV)
FORCE=TRUE;
```

---

# 🔄 Additional Scenario-Based Questions

### Snowflake Architecture
- **Q28.** Your team needs zero-downtime scaling for concurrent BI queries. Which feature ensures this?  
**A28.** Multi-cluster warehouses + separation of compute/storage.  

### Warehouse
- **Q29.** A warehouse pauses due to inactivity. Next query takes long to start. Why?  
**A29.** Because Snowflake needs to auto-resume the warehouse. Enable `AUTO_RESUME=TRUE` to reduce wait.  

### Database & Schema
- **Q30.** You want to grant access only to Sales schema inside COMPANY_DB. How do you do it?  
**A30.**  
```sql
GRANT USAGE ON DATABASE COMPANY_DB TO ROLE SALES_ROLE;
GRANT USAGE ON SCHEMA COMPANY_DB.SALES TO ROLE SALES_ROLE;
```

### Stage
- **Q31.** You want team members to access shared CSVs for multiple tables. Which stage is best?  
**A31.** Create a **named internal stage** with shared access.  

### Column Count
- **Q32.** You need to find which table has the maximum number of columns in a schema. How?  
**A32.**  
```sql
SELECT TABLE_NAME, COUNT(*) AS col_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='PUBLIC'
GROUP BY TABLE_NAME
ORDER BY col_count DESC;
```

### Loading Data
- **Q33.** Business team sends JSON data in S3. How do you load?  
**A33.** Create external stage with JSON file format and use `COPY INTO`.  

### Transforming
- **Q34.** You need to add a load timestamp to every row during ingestion. How?  
**A34.**  
```sql
COPY INTO ORDERS
FROM (SELECT $1, $2, CURRENT_TIMESTAMP FROM @stg_orders)
FILE_FORMAT=(TYPE=CSV);
```

### COPY INTO / Errors
- **Q35.** You want to load 10 CSVs but skip any file with >50 errors. Which option?  
**A35.** `ON_ERROR='SKIP_FILE_50'`.  

### Scaling
- **Q36.** Why might scaling up not improve performance for many small concurrent queries?  
**A36.** Because concurrency requires scaling **out**, not just bigger single cluster.  

### FORCE
- **Q37.** What risk is there in using FORCE=TRUE often?  
**A37.** Duplicate data may be inserted since Snowflake ignores file load history.  
