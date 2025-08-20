
# 📘 Snowflake Streams – Detailed Notes

## 🔹 1. What is a Stream in Snowflake?
- A **Stream** in Snowflake is a **change data capture (CDC) mechanism** that tracks all **DML changes** (`INSERT`, `UPDATE`, `DELETE`) made to a table.  
- Think of a **Stream** as a **bookmark** or **CDC log** that records row-level changes.  
- The stream does not physically store the changed data; instead, it stores **metadata** pointing to changes in the source table.  

👉 A stream always belongs to a **specific table** and reflects **only changes since the last consumption**.

---

## 🔹 2. Why Use Streams?
- To **capture incremental changes** without reloading the entire table.  
- To build **real-time or near real-time pipelines** with **low-latency data movement**.  
- To simplify **CDC** compared to traditional ETL tools (like log-based CDC).  
- To integrate with **Tasks** (Snowflake’s scheduler) for **automated ETL pipelines**.

---

## 🔹 3. How Streams Work (Internal Concept)
1. When you create a stream on a table, Snowflake starts tracking changes.  
2. Whenever rows are inserted, updated, or deleted:
   - The stream records them in a **change log**.  
   - Each record is annotated with:
     - `METADATA$ACTION` → `INSERT` or `DELETE`  
     - `METADATA$ISUPDATE` → `TRUE` for update operations  
3. When you **query the stream**, it returns **only the new changes** since the last query.  
4. Once consumed, the stream’s offset moves forward (like Kafka or Debezium offsets).  

---

## 🔹 4. Types of Streams
Snowflake supports **two types of streams**:

1. **Standard Stream**
   - Tracks row changes until consumed.  
   - After consumption, changes are marked as read and will not appear again.  

2. **Append-only Stream**
   - Tracks only **inserts**, not updates or deletes.  
   - Useful for **append-only scenarios** like logs and IoT data.  

---

## 🔹 5. Syntax & Example

### Step 1: Create Base Table
```sql
CREATE OR REPLACE TABLE CUSTOMERS (
    ID INT,
    NAME STRING,
    CITY STRING
);
```

### Step 2: Create Stream
```sql
CREATE OR REPLACE STREAM CUSTOMERS_STREAM ON TABLE CUSTOMERS;
```

### Step 3: Perform DML
```sql
INSERT INTO CUSTOMERS VALUES (1, 'John', 'New York');
UPDATE CUSTOMERS SET CITY = 'Boston' WHERE ID = 1;
DELETE FROM CUSTOMERS WHERE ID = 1;
```

### Step 4: Query Stream
```sql
SELECT * FROM CUSTOMERS_STREAM;
```

📌 Output Example:  
| ID | NAME | CITY   | METADATA$ACTION | METADATA$ISUPDATE |
|----|------|--------|-----------------|------------------|
| 1  | John | NY     | INSERT          | FALSE            |
| 1  | John | Boston | DELETE          | TRUE             |
| 1  | John | Boston | INSERT          | TRUE             |

👉 This shows **exactly what changed** since last read.  

---

## 🔹 6. Use Cases of Streams

### ✅ 1. **Incremental Data Processing**
- Instead of reloading entire sales data daily, use streams to capture only new or changed rows.
- Example: **Daily Sales ETL Pipeline** – only new transactions from `SALES_STREAM` are moved to `FACT_SALES`.

---

### ✅ 2. **Change Data Capture for Downstream Systems**
- Capture changes in Snowflake and push them to other systems (e.g., Kafka, Azure Event Hub, AWS S3).  
- Example: Sync **customer master data** with CRM whenever changes occur.

---

### ✅ 3. **Data Lakehouse ETL**
- Streams + Tasks automate **bronze → silver → gold** data flow in Medallion architecture.
- Example: IoT sensor data → Stream detects changes → Task moves cleaned records into analytics tables.

---

### ✅ 4. **Slowly Changing Dimension (SCD) Management**
- Stream helps track historical changes in dimensions.  
- Example: **Customer address updates** → Use streams to detect changed rows and update **Dimension tables**.

---

### ✅ 5. **Audit & Compliance**
- Maintain a **log of every change** for auditing purposes.  
- Example: Financial transactions → Streams provide row-level change history for auditing.

---

## 🔹 7. Best Practices
- Always pair Streams with **Tasks** for automated processing.  
- Use **Append-only streams** if updates/deletes are not needed (saves cost & performance).  
- Consider **retention period** (default 14 days) to ensure you don’t miss unconsumed changes.  
- Avoid excessive querying of streams (each query consumes state).  

---

# 📝 Summary
- **Streams in Snowflake = Change Data Capture (CDC)** mechanism for tables.  
- **Why use them?** → To process only incremental changes, enable real-time pipelines, simplify CDC.  
- **Real-world use cases** → Incremental ETL, CDC for external systems, SCDs, Audit logging, Medallion architecture.  
- **Integration** → Best used with **Tasks** for automated ETL.  
