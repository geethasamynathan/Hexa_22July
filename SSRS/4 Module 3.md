![alt text](image-50.png)

![alt text](image-51.png)

open Microsoft report builder
![alt text](image-53.png)

choose table or matrix wizard

![alt text](image-54.png) -> Click on Browse
![alt text](image-55.png)
![alt text](image-56.png)
![alt text](image-57.png)
![alt text](image-58.png)
![alt text](image-59.png)
![alt text](image-60.png)
![alt text](image-61.png)
![alt text](image-62.png)
![alt text](image-63.png)

![alt text](image-64.png)

![alt text](image-65.png)
![alt text](image-66.png)
![alt text](image-67.png)
![alt text](image-68.png)
![alt text](image-69.png)
![alt text](image-70.png)

Select the header Row
![alt text](image-71.png)
in view Mode ->select grouping
![alt text](image-72.png)
![alt text](image-73.png)

view tab-> Uncheck the grouping
Goto ->Home Tab => Run 
![alt text](image-74.png)

Now title visible in all pages . To check navigate to last page,..
and check
![alt text](image-75.png)

we created report using Microsoft Report Builder


Now come back vs 2022 ->
![alt text](image-76.png)
![alt text](image-77.png)

![alt text](image-78.png)
![alt text](image-79.png)
ok
![alt text](image-80.png)

If not available -> View tab ->Report Data

![alt text](image-81.png)

another way to create new column
![alt text](image-82.png)

Preview
![alt text](image-83.png)

Now check the connection string in SalesInfo
 Data Source -> Re configure =>Test Connection
 
 ![alt text](image-84.png)

 There is no grouping and format for order date
 let us do it

 ![alt text](image-85.png)

 ![alt text](image-86.png)

 ![alt text](image-87.png)
 ![alt text](image-88.png)
 ![alt text](image-89.png)
 ![alt text](image-90.png)
 ![alt text](image-91.png)

 Add Total
 ![alt text](image-92.png)

 ![alt text](image-93.png)

 ![alt text](image-94.png)

 ![alt text](image-95.png)

 Grand Total

 ![alt text](image-96.png)

 ![alt text](image-97.png)
 ![alt text](image-98.png)  
 ![alt text](image-99.png)

 ![alt text](image-100.png)

 ## Repeat Header Row on Each Page in Visual Studio 2022
 ## ✅ Repeat Table Header on Each Page in SSRS (Visual Studio 2022)

### 🔹 1. Open Your Report (`.rdl`) in Design View
- Make sure you are in the **Design** tab (not Preview).

---

### 🔹 2. Click on the Table or Tablix
- Click anywhere inside your table (your data grid).
- In the top-left corner of the table, click the **small square handle** to select the whole table.

---

### 🔹 3. Open the Row Groups Pane
- If it's hidden, go to:
View > Grouping

- You’ll see a panel with **Row Groups** and **Column Groups**.

---

### 🔹 4. Right-Click the Top-most `(static)` Row in Row Groups
- In the **Row Groups** pane, find the top `(static)` group — this represents your **header row**.
- Right-click → **Properties**.

---

### 🔹 5. Enable Repeat Options in Properties
Set the following:

- `RepeatOnNewPage = True`
- `KeepWithGroup = After`
- `FixedData = True` *(optional – keeps the header visible while scrolling)*

---

### 🔹 6. Save and Preview
- Save the `.rdl` file.
- Click the **Preview** tab.

✅ Now the **header row should repeat on all pages**.


Select Column header Row -> make it bold


We are goig to so the same report using Wizard


![alt text](image-101.png)

![alt text](image-102.png)
![alt text](image-103.png)

![alt text](image-104.png)

![alt text](image-105.png)

![alt text](image-106.png)

![alt text](image-107.png)
![alt text](image-108.png)
![alt text](image-109.png)