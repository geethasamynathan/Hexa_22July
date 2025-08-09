# 📊 Importing an Excel File into SQL Server Using SSIS (Step-by-Step Guide)

## 🎯 Objective:
To import data from an Excel file (`person.xlsx`) into a SQL Server database using an SSIS package and SQL Server Data Tools (SSDT) 2015.

---

## 📂 Sample File:
- File: `person.xlsx`
- Location: `C:\files\person.xlsx`
- Records: ~1000
- Sheet: Contains person data

---

## 🧰 Prerequisites:
- SQL Server 2019 or later (Developer Edition)
- SSIS Project using vs 2022
- A database named `testing` (empty at the beginning)

---

## 🔧 Step-by-Step Instructions

### ✅ Step 1: Create SSIS Project in vs 2022
- - Create a new **Integration Services Project**
- Open the default package (e.g., `package.dtsx`) or add new SSIS Package

---

### ✅ Step 2: Add a Data Flow Task
- From **SSIS Toolbox**, drag **Data Flow Task** into **Control Flow**
- Rename it `Import Excel File`
- Double-click to enter the **Data Flow**

---

### ✅ Step 3: Configure Excel Source
- In Data Flow, drag **Excel Source** to the canvas
- Double-click to configure:
  - Click **New** to create a connection
  - Browse to: `C:\files\person.xlsx`
  - Choose the worksheet from the dropdown
  - Click **Preview** to check sample data
  - Go to **Columns** tab → review or rename output column names
  - Click **OK**

---

### ✅ Step 4: Configure OLE DB Destination
- Drag **OLE DB Destination** to Data Flow
- Connect Excel Source → OLE DB Destination using blue arrow (data path)
- Double-click OLE DB Destination to configure:
  - Click **New** to create a connection manager
    - Server Name: `(local)`
    - Database: `testing`
    - Click **Test Connection**
  - Click OK

---

### ✅ Step 5: Table Creation from SSIS
- Data Access Mode: `Table or view – fast load`
- Click **New** to auto-generate the table structure from Excel columns
- Table Name: `person_data`
- Confirm table created in SQL Server `testing` database

---

### ✅ Step 6: Column Mappings
- Click **Mappings**
- Ensure all source columns are correctly mapped to destination columns
- Map manually if any mismatch
- Click **OK**

---

### ✅ Step 7: Execute the Package
- In SSDT, go to **Debug > Start Debugging** or press `F5`
- Wait for execution: ✔️ Green checks indicate success

---

### ✅ Step 8: Verify Data in SQL Server
Run the following query in **SQL Server Management Studio (SSMS)**:
```sql
SELECT * FROM testing.dbo.person_data;
```
You should see all ~1000 records successfully imported.

---

## 🔄 Recap: Data Flow Diagram

```
Excel File → Excel Source → OLE DB Destination → SQL Server Table
```

---

## 🧠 Notes:
| Feature | Description |
|--------|-------------|
| Fast Load Mode | Optimizes bulk inserts |
| Auto Table Creation | Creates table based on Excel metadata |
| Preview Option | Useful for validating Excel content before import |
| Excel Source | Works with `.xlsx` and `.xls` formats |
| OLE DB Destination | Required for SQL Server insert |

---

## ✅ Use Case:
Ideal for loading master data, customer/person details, or survey records from Excel sheets into your SQL-based applications or warehouse.

