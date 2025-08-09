# 📦 Copy Data from One SQL Server to Another using SSIS

### 🎯 Objective:
To copy data from two tables (`Customer` and `XMLData`) in SQL Server 2014 to another instance of SQL Server 2016 using SSIS.

---

## 🧠 Why Use SSIS?

| Method | Availability Needed | Scheduling | Reusability |
|--------|----------------------|------------|-------------|
| **Import/Export Wizard** | You must be present | ❌ | ❌ |
| **SSIS Package** | Can run in background | ✅ (using SQL Agent) | ✅ |

---

## 🔧 Software/Environment Used

- **SQL Server 2014**: Source DB instance with `Customer` and `XMLData` tables
- **SQL Server 2016**: Destination instance (empty `Testing` database)
- **SSIS (SQL Server Data Tools 2015)**: To create the ETL package

---

## 🚶 Step-by-Step Guide

### 🎬 1. Create a New SSIS Package

- Open **SQL Server Data Tools (SSDT 2015)**
- In **Control Flow**, drag and drop a **Data Flow Task**

---

### 🔁 2. Configure the Data Flow Task for `Customer` Table

#### 📤 Source: SQL Server 2014
- Double-click **Data Flow Task** to go to **Data Flow**
- Drag **OLE DB Source**
- Create a new connection → Connect to SQL Server 2014 → Choose `Testing` DB
- In **OLE DB Source Editor**, select table `Customer`

#### 📥 Destination: SQL Server 2016
- Drag **OLE DB Destination**
- Connect green arrow from source to destination
- Double-click to configure destination
- Create new connection to `INL-AHMED\2016` → Choose `Testing` DB
- Click **New** to auto-create the `Customer` table at the destination
- Go to **Mappings** → Ensure columns are mapped correctly
- Click **OK**

---

### 🔁 3. Repeat Steps for `XMLData` Table

- In the same Data Flow:
  - Drag another **OLE DB Source** and **OLE DB Destination**
- Configure source:
  - Choose SQL 2014 → Table: `XMLData`
- Configure destination:
  - Choose SQL 2016 → Create new table `XMLData`
  - Verify **Mappings**

---

### ▶️ 4. Execute the SSIS Package

- Go to **Debug Menu** → Click **Start Debugging** or press **F5**
- Package runs and shows number of rows transferred:
  - `Customer`: 6 records
  - `XMLData`: 1000 records

---

## ✅ Post-Execution Check (SSMS)

- Open **SQL Server Management Studio** → Connect to SQL Server 2016
- Expand the `Testing` database → Refresh **Tables**
- You should see:
  - `Customer` table with 6 records
  - `XMLData` table with 1000 records

---

## 📝 Summary

| Task | Description |
|------|-------------|
| 🎯 Goal | Copy tables between SQL Server instances |
| 🛠️ Tool Used | SSIS Data Flow |
| 📚 Tables | `Customer`, `XMLData` |
| 🔗 Source | SQL Server 2014 |
| 🏁 Destination | SQL Server 2016 |
| 🕒 Scheduling | Possible with SQL Agent |
| ✅ Output | Tables created and data successfully copied |
