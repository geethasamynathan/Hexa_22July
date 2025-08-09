
# 🍼 SSIS Baby Notes  
## 📤 Export Data from SQL Server Table to Fixed Width File

---

## 🎯 Objective:
To **export data from a SQL Server table** (e.g., `Person.EmailAddress`) into a **Fixed Width File** using **SSIS**.

---

## 🛠 Why Fixed Width?
- ✅ Better for **huge data volumes** (millions/billions of rows).
- ✅ Avoids **delimiter issues** that occur with CSV.
- ✅ Maintains strict field size for **legacy systems or external interfaces**.

---

## 🧩 Step-by-Step Guide:

### 🔶 Step 1: Write a Custom SELECT Query
Instead of letting SSIS infer column sizes from the table, use a custom query to fix column widths:
```sql
SELECT 
  CAST(BusinessEntityID AS CHAR(20)) AS BusinessEntityID,
  CAST(EmailAddressID AS CHAR(20)) AS EmailAddressID,
  CAST(EmailAddress AS CHAR(50)) AS EmailAddress,
  CAST(rowguid AS CHAR(50)) AS RowGuid
FROM Person.EmailAddress
```
This ensures each column has a **fixed width** (e.g., 20 or 50 characters).

---

### 🔶 Step 2: Open SSDT and Create SSIS Project
1. Open **SQL Server Data Tools 2015**.
2. Create a new **Integration Services Project**.
3. Name your project: `ExportFixedWidth`.

---

### 🔶 Step 3: Add a Data Flow Task
1. In **Control Flow**, drag **Data Flow Task** from the toolbox.
2. Rename it: `Export Fixed Width Data`.
3. Double-click to enter the **Data Flow** tab.

---

### 🔶 Step 4: Configure OLE DB Source
1. Drag **OLE DB Source** into the Data Flow area.
2. Double-click to configure:
   - Connect to SQL Server 2016 (e.g., `INL-AHMED\SQL2016`).
   - Choose database: `AdventureWorks2014`.
   - Use the custom SQL query (from Step 1).
   - Click **Preview** to view data.
   - Click **OK**.

---

### 🔶 Step 5: Configure Flat File Destination
1. Drag **Flat File Destination** into the Data Flow.
2. Connect **OLE DB Source → Flat File Destination** using blue arrow.
3. Double-click Flat File Destination:
   - Click **New** to create a connection.
   - Choose **Ragged Right** format (used for fixed-width files with row delimiters).
   - Click **Browse** and create file `fixedwidthfile.txt`.
   - Click **OK**.

---

### 🔶 Step 6: Map Columns
1. Go to **Mappings** tab.
2. Make sure all columns are correctly mapped.
3. Click **OK**.

---

### 🔶 Step 7: Run the Package
1. From the top menu, click **Start Debugging** (or press `F5`).
2. Wait for **green ticks** on both tasks to confirm success.

---

## ✅ Output:
A **Fixed Width File** named `fixedwidthfile.txt` will be created with columns padded according to their defined widths.

Example:
- BusinessEntityID → 20 characters
- EmailAddressID → 20 characters
- EmailAddress → 50 characters
- RowGuid → 50 characters

---

## 🧠 Notes:
- Avoid using **Fixed Width** format in the Flat File Connection — use **Ragged Right** instead.
- You must **predefine the column widths** using `CHAR(n)` in your SQL query.
- Great for systems expecting **structured positional data**.
