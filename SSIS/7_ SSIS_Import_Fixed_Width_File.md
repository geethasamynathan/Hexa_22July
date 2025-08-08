# 📦 Importing a Fixed Width File into SQL Server Using SSIS (Step-by-Step Guide)

## 🎯 Objective:
To import a fixed-width flat file (e.g., `customer.txt`) into a SQL Server table using **SQL Server Data Tools (SSDT) 2015** and **SSIS package**.

---

## 📂 Sample Fixed Width File: `customer.txt`

This file has 6 records with columns aligned at specific positions.

### Example Layout:
| Column Name     | Start Position | End Position | Length |
|----------------|----------------|--------------|--------|
| CustomerID     | 1              | 7            | 7      |
| CustomerName   | 8              | 27           | 20     |
| CustomerCity   | 28             | 42           | 15     |

---

## 🧰 Requirements:
- SQL Server 2014 or higher
- SQL Server Data Tools 2015 (SSDT)
- Fixed-width file (e.g., `customer.txt`)
- Layout/column position information for the file

---

## 🔧 Step-by-Step Instructions

### ✅ Step 1: Create SQL Server Table
Use this script in **SQL Server Management Studio (SSMS)**:
```sql
CREATE TABLE Customers (
    CustomerID VARCHAR(7),
    CustomerName VARCHAR(20),
    CustomerCity VARCHAR(15)
);
```

---

### ✅ Step 2: Open SQL Server Data Tools
- Launch **SQL Server Data Tools 2015**.
- Create a new **Integration Services Project**.
- Name it: `ImportFixedWidthFile`.

---

### ✅ Step 3: Add Data Flow Task
- In **Control Flow**, drag **Data Flow Task**.
- Rename it: `Load Fixed Width File`.
- Double-click to open **Data Flow** tab.

---

### ✅ Step 4: Configure Flat File Source
- Drag **Flat File Source** from SSIS Toolbox.
- Double-click → Click **New** to configure a new connection.
- Browse and select the `customer.txt` file.
- Set **Format** to: `Fixed width`.
- Go to **Advanced tab** and define each column:

#### ➕ Add Columns:
| Name           | Length |
|----------------|--------|
| CustomerID     | 7      |
| CustomerName   | 20     |
| CustomerCity   | 15     |

Also, add a **dummy column** of length `2` for row delimiters if needed.

- Click **Preview** to verify file contents.
- Click **OK** to save the source connection.

---

### ✅ Step 5: Configure OLE DB Destination
- Drag **OLE DB Destination** from SSIS Toolbox.
- Connect Flat File Source ➝ OLE DB Destination using the blue data path.
- Double-click destination → Click **New** to configure connection manager.

#### ➕ Configure Connection:
- Server name: `(local)` or your server name
- Database: `SSIS`
- Test connection and click OK

#### ⚙️ Destination Setup:
- Data access mode: `Table or view – fast load`
- Table name: `Customers`
- Go to **Mappings** → Ensure all source columns map to destination columns
- Click OK

---

### ✅ Step 6: Execute the Package
- Right-click on the package in **Control Flow**.
- Click **Execute Task**
- Green checkmarks ✔️ indicate success.

---

### ✅ Step 7: Verify the Import
Run this SQL query in SSMS:
```sql
SELECT * FROM Customers;
```
You’ll see all 6 records successfully imported.

---

## 🔄 Recap: Data Flow

```
Fixed Width File → Flat File Source → OLE DB Destination → SQL Server Table
```

---

## 🧠 Notes:
| Topic                     | Explanation |
|--------------------------|-------------|
| Fixed Width File         | Requires manual layout definition |
| CSV vs Fixed Width       | CSV auto-detects columns; fixed width needs manual configuration |
| Dummy Column             | Needed to represent row delimiter in some cases |
| Fast Load Mode           | Enables efficient bulk insert |
| Preview & Mappings       | Helps ensure correct structure before load |
