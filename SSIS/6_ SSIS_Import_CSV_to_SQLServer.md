# 📥 Importing a CSV File into SQL Server using SSIS (Step-by-Step Guide)

## 🎯 Objective:
To import data from a `.csv` file (e.g., `courses.csv`) into a SQL Server database table using **SQL Server Data Tools (SSDT) 2015** and **SQL Server 2014** through an SSIS package.

---

## 🧰 Prerequisites:
- SQL Server 2014 installed
- SQL Server Data Tools 2015 (SSDT)
- Sample CSV file (`courses.csv`) with the following columns:
  - CourseID, CourseName, CourseDuration, CollegeName

---

## 📂 Sample CSV Content:
```
CourseID,CourseName,CourseDuration,CollegeName
1,Computer Science,60,MIT
2,Mathematics,45,Harvard
4,Physics,50,Stanford
5,Chemistry,40,Oxford
6,Biology,55,Cambridge
7,English,35,Yale
```
_Note: Record with CourseID=3 is intentionally missing to show it's not a sequence._

---

## 🔧 Step-by-Step Instructions:

### ✅ Step 1: Create SQL Server Table
Open **SQL Server Management Studio (SSMS)** and create a new table using the below script:
```sql
CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(100),
    CourseDuration INT,
    CollegeName VARCHAR(100)
);
```
Execute the script to create an empty destination table in the `SSIS` database.

---

### ✅ Step 2: Open SQL Server Data Tools 2015
- Launch **SQL Server Data Tools (SSDT) 2015**.
- Click **File > New > Project**.
- Select **Integration Services Project**.
- Name the project: `LoadCSVFile`.

---

### ✅ Step 3: Add Data Flow Task
- In **Control Flow**, drag and drop a **Data Flow Task**.
- Rename it to `Load CSV Data`.
- Double-click to enter the **Data Flow** tab.

---

### ✅ Step 4: Configure Flat File Source
- From **SSIS Toolbox**, drag **Flat File Source** to Data Flow.
- Right-click → Edit → New.
- **Set Connection Manager Properties:**
  - Name: `CoursesCSV`
  - Format: Delimited
  - Browse to: `courses.csv`
  - Check: `Column names in the first row`
  - Preview the data to confirm
- Go to **Columns** tab → Verify columns
- Click OK to finish setup

---

### ✅ Step 5: Configure OLE DB Destination
- Drag **OLE DB Destination** from toolbox.
- Connect Flat File Source → OLE DB Destination.
- Right-click OLE DB Destination → Edit → New.
- **Configure Connection Manager:**
  - Server: (e.g., `yourservername`)
  - Database: `SSIS`
  - Test Connection → Success
- Set **Data Access Mode**: `Table or view – fast load`
- Choose Table: `Courses`
- Click **Mappings**:
  - Ensure all source fields map to destination fields correctly
- Click OK

---

### ✅ Step 6: Execute the Package
- Go back to **Control Flow**
- Right-click the Data Flow Task → Click **Execute Task**
- Watch for **green ticks** ✔️ on both source and destination indicating success

---

### ✅ Step 7: Verify the Data
Go to **SQL Server Management Studio (SSMS)** and run:
```sql
SELECT * FROM Courses;
```
You will see all records from `courses.csv` successfully imported.

---

## 🔄 Recap Flow Diagram:

```
CSV File --> Flat File Source --> OLE DB Destination --> SQL Server Table
```

---

## 📚 Advanced Notes:

| Feature | Description |
|--------|-------------|
| Fast Load Mode | Enables bulk insert for high performance |
| Flat File Source | Used for delimited files like .csv or .txt |
| OLE DB Destination | Used to write to SQL Server or other OLE DB targets |
| Mappings | Ensures each column from source is correctly aligned with destination |
| Execution Validation | Green checkmarks indicate successful task run |

---

## 🧠 Real-World Use Case:
> Use this flow when integrating daily/weekly sales reports from CSV format into your Data Warehouse or reporting database.
