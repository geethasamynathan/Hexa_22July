
# 🍼 SSIS Baby Notes  
## 📤 Export Data from SQL Server Table to CSV File

---

## 🎯 Objective:
To **read data from a SQL Server table** (e.g., `testdata`) and **write it into a CSV file** using **SSIS**.

---

## 🛠 Prerequisites:
- SQL Server with a table (e.g., `testdata`) having data.
- SQL Server Data Tools (SSDT) or Visual Studio with SSIS installed.

---

## 🧩 Step-by-Step Guide:

### 🔶 Step 1: Open SSDT and Create a New SSIS Project
1. Open **SQL Server Data Tools 2015**.
2. Go to **File → New → Project → Integration Services Project**.
3. Name your project (e.g., `ExportToCSV`).

---

### 🔶 Step 2: Add a Data Flow Task
1. In the **Control Flow** tab, drag a **Data Flow Task** from the toolbox.
2. Rename it: `Export Data to CSV`.

---

### 🔶 Step 3: Configure the Source (SQL Server Table)
1. Double-click on the **Data Flow Task** to go into **Data Flow** tab.
2. Drag **OLE DB Source** from the toolbox into the Data Flow area.
3. Double-click the **OLE DB Source** to configure it:
   - Create/select a connection to your **SQL Server**.
   - Choose the database (e.g., `testing`).
   - Select the table: `testdata`.
   - Click **Preview** to check the data.
   - Click **OK**.

---

### 🔶 Step 4: Configure the Destination (CSV File)
1. Drag a **Flat File Destination** to the Data Flow tab.
2. Connect the **blue arrow** from **OLE DB Source → Flat File Destination**.
3. Double-click **Flat File Destination** to configure:
   - Click **New** to create a connection manager.
   - Choose **Delimited** as the format.
   - Browse and select a location to save the CSV file.
   - Name the file: `exporteddata.csv`.
   - Click **Open** (the file will be created if it doesn’t exist).
   - Click **OK**.

---

### 🔶 Step 5: Map Columns
1. In the **Flat File Destination Editor**, click **Mappings** tab.
2. Ensure all source columns are mapped to destination columns.
3. Click **OK**.

---

### 🔶 Step 6: Run the Package
1. Click **Start Debugging** (green play button).
2. Wait for the green ticks on both tasks — means success.
3. Navigate to the folder you selected and open `exporteddata.csv`.

---

## ✅ Output:
A CSV file named `exporteddata.csv` will be created, containing the **1000 rows and 5 columns** from your `testdata` SQL table.

---

## 🧠 Notes:
- Make sure the file is not open before running the package again.
- You can automate this task using **SQL Server Agent** if needed.
- Use `.txt` or `.csv` as per your needs by changing the file extension.
