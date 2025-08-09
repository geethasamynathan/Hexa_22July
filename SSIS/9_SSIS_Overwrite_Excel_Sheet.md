# 🔁 Overwrite Excel Sheet in SSIS: Drop and Recreate Sheet (Step-by-Step)

## 🎯 Objective:
Learn how to **overwrite data** in an Excel file using **SSIS** by **dropping and recreating** the Excel sheet before each load.

---

## 📂 Scenario:
We are reading data from a **SQL Server table** (`City`) and writing it to an **Excel file**. Every time the package runs, we want to:
1. Drop the existing Excel sheet
2. Recreate the sheet
3. Insert fresh data from SQL Server

---

## ⚠️ Why This is Needed:
- **Excel Connection Manager** does **not** provide overwrite functionality (unlike flat files).
- By default, SSIS **appends** data to Excel.
- We need to **ensure fresh data every time** for reporting or exports.

---

## 🧰 Prerequisites:
- SQL Server 2019 or later (Developer Edition)
- SSIS Project using vs 2022
- Excel file named `city.xlsx` inside `C:\files`

---

## 🔧 Step-by-Step Instructions

### ✅ Step 1: SQL Server Setup
Create a `City` table in the `testing` database:
```sql
CREATE TABLE City (
    ID INT,
    City VARCHAR(100),
    Country VARCHAR(100)
);
```
Insert 7 rows of sample data.

---

### ✅ Step 2: Create SSIS Project
- Launch SSDT
- Create a new **Integration Services Project**
- Drag **Data Flow Task** into Control Flow

---

### ✅ Step 3: Read Data from SQL Server
- Open Data Flow tab
- Drag **OLE DB Source** → Configure:
  - Connection: Server = `developer`, DB = `testing`
  - Table: `City`
  - Preview the data and click OK

---

### ✅ Step 4: Convert `VARCHAR` to `NVARCHAR`
- Excel only supports **Unicode (nvarchar)**.
- Drag **Data Conversion Task**:
  - Input: `City`, `Country`
  - Output Data Type: `Unicode string [DT_WSTR]`
  - Output Aliases: `copy of City`, `copy of Country`
- Connect OLE DB Source → Data Conversion

---

### ✅ Step 5: Write to Excel File
- Drag **Excel Destination**
- Connect from Data Conversion output
- Create Excel Connection Manager:
  - New file: `C:\files\city.xlsx`
  - New Sheet: `MyData`
- Configure Mappings:
  - Map `copy of City` to `City`, `copy of Country` to `Country`

---

### ✅ Step 6: Handle Sheet Re-creation
- Back to **Control Flow**
- Add **Execute SQL Task** before Data Flow Task
- Set:
  - **Connection Type**: Excel
  - **Connection**: Excel Connection Manager
  - **SQL Statement**:
```sql
DROP TABLE [MyData];
GO
CREATE TABLE [MyData] (
    [City] NVARCHAR(100),
    [Country] NVARCHAR(100)
);
```

---

### ✅ Step 7: Link Tasks
- Connect **Execute SQL Task → Data Flow Task**
- This ensures the sheet is dropped and recreated before load

---

### ✅ Step 8: Execute the Package
- Press `F5` or click **Start Debugging**
- Output: Excel file will have exactly 7 records, overwritten fresh each time

---

## 📊 Recap: Flow Diagram

```
SQL Server → OLE DB Source → Data Conversion → Excel Destination
         ↑                                       ↓
    Execute SQL Task ———(Drop + Create Excel Sheet)
```

---

## 🧠 Key Points:
| Feature                     | Description |
|----------------------------|-------------|
| Excel Destination Limitation | Cannot overwrite directly |
| Data Conversion             | Required for varchar → nvarchar |
| Execute SQL Task            | Used to drop and recreate Excel sheet |
| Fast Load                  | Ensures efficient writing |
| Unicode Required           | Excel only supports Unicode strings |

---

## ✅ Result:
On every execution, the Excel file is cleaned and filled with the latest data from SQL Server — no duplicates, no appends.

