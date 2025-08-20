# ❄️ Snowflake Tasks – Notes

## 1. Definition
A **Task in Snowflake** is a **scheduled object** that runs a **SQL statement (DML or stored procedure)** automatically, without manual intervention.  

- Acts like a **scheduler + automation tool** within Snowflake.  
- Executes at specific time intervals (CRON) or after a **dependent task** completes.  

---

## 2. Key Features
- Supports **CRON expressions** for advanced scheduling.  
- Can **chain tasks** (task trees).  
- Executes **SQL statements** or **procedures**.  
- Uses a **warehouse** for compute.  
- Tasks can be **paused, resumed, altered, or dropped**.

---

## 3. Types of Tasks in Snowflake

### 🔹 (A) Standalone Task
Runs independently on a defined schedule.

✅ **Use Case**: Load data from staging into production every night.

```sql
CREATE OR REPLACE TASK Load_Sales_Data
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON 0 2 * * * UTC'
AS
  INSERT INTO SALES_FINAL
  SELECT * FROM SALES_STAGE;
```

---

### 🔹 (B) Task with Stored Procedure
Calls a stored procedure instead of plain SQL.  
Useful for **complex logic** (loops, conditions, error handling).  

✅ **Use Case**: Clean rejected records daily.

```sql
CREATE OR REPLACE PROCEDURE Clean_Rejected()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
    var sql = "DELETE FROM REJECTED_RECORDS WHERE LOAD_DATE < DATEADD(DAY, -30, CURRENT_DATE)";
    snowflake.execute({sqlText: sql});
    return "Old records cleaned";
$$;

CREATE OR REPLACE TASK Clean_Reject_Task
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON 0 3 * * * UTC'
AS
  CALL Clean_Rejected();
```

---

### 🔹 (C) Chained (Dependent) Tasks
Runs only after another task completes.  
Forms a **task tree** (workflow).  

✅ **Use Case**: Multi-step ETL pipeline.

```sql
-- 1. Load raw data into staging
CREATE OR REPLACE TASK Load_Stage
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON 0 1 * * * UTC'
AS
  COPY INTO STAGING_TABLE FROM @my_stage FILE_FORMAT = (TYPE=CSV);

-- 2. Transform data after loading
CREATE OR REPLACE TASK Transform_Data
  WAREHOUSE = COMPUTE_WH
  AFTER Load_Stage
AS
  INSERT INTO ANALYTICS_TABLE
  SELECT * FROM STAGING_TABLE WHERE STATUS='VALID';

-- 3. Aggregate into summary after transformation
CREATE OR REPLACE TASK Refresh_Summary
  WAREHOUSE = COMPUTE_WH
  AFTER Transform_Data
AS
  INSERT INTO SALES_SUMMARY
  SELECT REGION, SUM(AMOUNT) AS TOTAL_SALES
  FROM ANALYTICS_TABLE
  GROUP BY REGION;
```

---

### 🔹 (D) Continuous Tasks
Triggered immediately after predecessor completes (event-driven).  

✅ **Use Case**:  
- File lands in stage → load into table → trigger transformation → refresh summary.

---

## 4. Real-World Example – Retail ETL Pipeline
**Scenario**: Walmart wants daily refreshed dashboards.  

1. **Task 1 – Load Sales Data** → `SALES_STAGE`  
2. **Task 2 – Transform Sales Data** → `SALES_CLEANED`  
3. **Task 3 – Aggregate Sales Summary** → `SALES_SUMMARY`  
4. **Task 4 – Notify BI Team** (via stored procedure + external API).  

**Workflow Diagram (Conceptual)**

```
[ Load Sales Data ] ---> [ Transform Data ] ---> [ Refresh Summary ] ---> [ Notify BI ]
```

---

## 5. Summary Table

| Task Type              | What it Does                          | Example Use Case        |
|-------------------------|----------------------------------------|-------------------------|
| Standalone Task         | Runs SQL on schedule                  | Load staging daily      |
| Task with Procedure     | Calls stored procedure                | Cleanup old data        |
| Chained Task            | Runs after another task               | Multi-step ETL pipeline |
| Continuous Task         | Runs instantly after predecessor      | Real-time ingestion     |

---
