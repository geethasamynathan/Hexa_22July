# 📘 SSIS File System Task – Detailed Notes

## 1. What is File System Task in SSIS?
The **File System Task** in SSIS (SQL Server Integration Services) is a **Control Flow** task that lets you perform file and folder operations within your package.  
It enables automation of file management tasks such as **copying, moving, deleting, and creating directories**.

**Key capabilities include:**
- Create a directory/folder
- Delete a directory/folder
- Copy a file from one location to another
- Move a file
- Delete a file
- Set file/folder attributes (Read-only, Hidden, etc.)

---

## 2. When to Use File System Task
Use the **File System Task** when:
- You need to **prepare folders** for data extraction or loading.
- Files must be **copied/moved** from a source directory to a processing folder before importing.
- Old or temporary files need to be **deleted** after processing.
- Output files need to be **archived**.
- You want to **automate housekeeping tasks** without manual intervention.

---

## 3. Why to Use File System Task
- **Automation** – Eliminates manual file management before/after ETL.
- **Consistency** – Ensures every ETL run works on the correct files in the right location.
- **Integration** – Works seamlessly inside SSIS Control Flow with other tasks.
- **Error Handling** – Can be combined with SSIS event handlers to log or handle file operation failures.

---

## 4. Where to Find It in SSIS Toolbox
- Open **SQL Server Data Tools (SSDT)** or **Visual Studio** with SSIS extension.
- Go to the **Control Flow** tab.
- In the **SSIS Toolbox** (on the left), find **File System Task** under **Common** or **General** tasks.

---

## 5. Step-by-Step Example – Create Directory & Copy File

**Scenario:**  
We have a file **Courses.csv** in `C:\Files`.  
We want to:
1. Create a new folder named **SSIS** inside `C:\Files`.
2. Copy **Courses.csv** into the newly created **SSIS** folder.

### Step 1 – Create Directory
1. **Drag and drop** **File System Task** into the Control Flow.
2. **Rename** it to `Create Directory`.
3. **Edit Task**:
   - **Operation** → `Create Directory`
   - **IsSourcePathVariable** → `True` (we'll store path in a variable)
   - **Variable** → Create a new SSIS variable:
     - Name: `User::NewDirectoryPath`
     - Value: `C:\Files\SSIS`
4. Save and close the editor.

### Step 2 – Copy File
1. **Drag and drop** another **File System Task** into Control Flow.
2. **Rename** it to `Copy File`.
3. **Edit Task**:
   - **Operation** → `Copy File`
   - **IsDestinationPathVariable** → `True`
     - Create a variable:
       - Name: `User::NewFilePath`
       - Value: `C:\Files\SSIS\Courses.csv`
   - **OverwriteDestination** → `True`
   - **Source** → Create a **File Connection Manager**:
     - Point to `C:\Files\Courses.csv`
4. Save and close the editor.

### Step 3 – Execution Order
- Connect **Create Directory** → **Copy File** with a green precedence constraint.
- This ensures the folder is created before the file is copied.

### Step 4 – Run & Verify
- Press **F5** to run the package.
- Expected Output:
  - A new folder `C:\Files\SSIS` is created.
  - The file `Courses.csv` is copied from `C:\Files` to `C:\Files\SSIS`.

---

## Real-World Use Case
In a **daily sales ETL process**:
- Sales data CSV is generated in `C:\IncomingFiles`.
- SSIS File System Task **moves** the file to `C:\ProcessedFiles` after loading.
- Another File System Task **archives** the file to `C:\Archive\YYYYMMDD`.

This ensures:
- Data is not processed twice.
- Archive is maintained for compliance.
- The incoming folder is kept clean.

---

## Trainer Tip: Best Practices
- **Always parameterize paths** using SSIS variables → makes the package environment-independent.
- **Check folder existence** before creating (or enable overwrite).
- Use **expressions** to build dynamic paths with timestamps.
- Avoid hardcoding file paths in the task properties.

---

## Summary Table

| Feature | Description | Example |
|---------|-------------|---------|
| **Task Type** | Control Flow Task | File System Task |
| **Purpose** | Manage files & directories | Copy, Move, Delete, Create Folder |
| **When to Use** | Automate pre/post ETL file handling | Archive data files after load |
| **Variables** | Store file/folder paths | `User::FilePath`, `User::FolderPath` |
| **Best Practice** | Use variables, avoid hardcoding | `C:\Data\%Date%\file.csv` |

---

## Diagram
![SSIS File System Task Diagram - Clear](ssis_file_system_task_diagram_clear.png)
