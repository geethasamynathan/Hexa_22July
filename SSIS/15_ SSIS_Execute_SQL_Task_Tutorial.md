
## 🛠 How to Use the Execute SQL Task in SSIS

---

## 🎯 Objective:
Learn how to use the **Execute SQL Task** in SSIS to run **static or dynamic SQL queries** such as `CREATE`, `INSERT`, `UPDATE`, or executing queries from **variables** and **files**.

---

## 🧩 What is Execute SQL Task?
The **Execute SQL Task** is used in SSIS to run SQL statements on a relational database. You can use it to:
- Create tables
- Insert, Update, Delete rows
- Run dynamic queries using variables or expressions
- Execute queries from external `.sql` files

---

## 🛠 Basic Usage Example: Create & Insert Data

### 1. Add Execute SQL Task
- Drag **Execute SQL Task** to the **Control Flow**.
- Rename to `Work with SQL Queries`.
- Double-click to open.

### 2. Configure Connection
- Set **Connection Type** to `OLE DB`.
- Create/select connection to SQL Server (e.g., Server: `.\SQLEXPRESS`, DB: `SSIS_DB`).

### 3. Write SQL Statement:
```sql
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Person')
BEGIN
  CREATE TABLE Person (
    ID INT IDENTITY(1,1),
    Name VARCHAR(50),
    Gender CHAR(1),
    Age INT
  )
END

INSERT INTO Person (Name, Gender, Age) VALUES ('Geetha', 'F', 35);
```

- Paste this into the **SQLStatement** box.

### 4. Run the Package
- Click **Start Debugging** (or press `F5`).
- ✅ The table will be created and a row inserted.

---

## 🧠 Using Parameters with Variables

### 1. Create SSIS Variables
Go to **Control Flow → Right Click → Variables**:
- Name: `Name`, Type: String, Value: `Ram`
- Name: `Gender`, Type: String, Value: `M`
- Name: `Age`, Type: Int32, Value: `30`

### 2. Update SQL Statement
```sql
INSERT INTO Person (Name, Gender, Age) VALUES (?, ?, ?);
```

### 3. Configure Parameter Mapping
- Index 0 → Variable: `Name`, Type: VARCHAR
- Index 1 → Variable: `Gender`, Type: VARCHAR
- Index 2 → Variable: `Age`, Type: LONG (INT)

### 4. Execute → One more row added using variable values

---

## 🧪 Using Expressions (Dynamic SQL)

### Steps:
1. Go to **Execute SQL Task → Expressions**.
2. Set `SQLStatementSource` to a dynamic expression like:
```sql
"INSERT INTO Person (Name, Gender, Age) VALUES ('" + @[User::Name] + "', '" + @[User::Gender] + "', " + (DT_WSTR, 12)@[User::Age] + ")"
```
3. Make sure to **cast integer** variables using `(DT_WSTR, length)`.
4. Click **Evaluate Expression** → OK.

### ✅ Output:
New record inserted using dynamic SQL string from expression.

---

## 📦 Executing SQL from Variable

1. Create a **String Variable**: `SqlQuery`  
2. Assign the SQL as expression:
```sql
"INSERT INTO Person (Name, Gender, Age) VALUES ('" + @[User::Name] + "', '" + @[User::Gender] + "', " + (DT_WSTR, 12)@[User::Age] + ")"
```
3. In Execute SQL Task, set `SQLSourceType = Variable` and choose `SqlQuery`.

✅ Now it executes query from variable.

---

## 📁 Executing SQL from File

1. Save your query in a `.sql` file (e.g., `person_query.sql`).
```sql
INSERT INTO Person (Name, Gender, Age) VALUES ('Vedha', 'F', 20);
```
2. In Execute SQL Task:
   - Set `SQLSourceType = File Connection`.
   - Create File Connection to `person_query.sql`.

✅ Executes the SQL script from the file.

---

## 🧠 Summary

| Feature | Purpose |
|--------|---------|
| **Direct Input** | Hardcoded query |
| **Parameter Mapping** | Dynamic values via variables |
| **Expressions** | Dynamically construct query |
| **Variable** | Store SQL in a string variable |
| **File** | Read query from a `.sql` file |

---

## ✅ Use Cases
- Automate schema creation (CREATE TABLE)
- Insert data using variables
- Run conditional logic using `IF EXISTS`
- Dynamically construct SQL with expressions

---

🎉 That’s how you master the **Execute SQL Task** in SSIS step-by-step!
