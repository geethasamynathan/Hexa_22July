
# 📘Assignment: Holiday Impact Analysis for HR Planning

:
You are working as a **Data Engineer** for a global HR Tech company. The HR team wants to analyze **official public holidays in the United States for the year 2025** to:

- Understand how holidays are distributed across months and weekdays.
- Plan employee availability, leave policy, and holiday-based team rotations.
- Store the holiday data in structured formats (CSV, JSON, Parquet) for downstream analytics in Azure.

The HR manager provides you a public API that lists U.S. holidays:
👉 `https://date.nager.at/api/v3/PublicHolidays/2025/US`

---

## 🎯 Assignment Tasks (Real-World Steps)

### 🔹 Task 1: Data Ingestion

**Q1.** Fetch the US 2025 public holidays from the provided API using Python.  
**Q2.** Convert the JSON response into a tabular format using Pandas.  
**Q3.** Save the dataset as a CSV file (`us_public_holidays_2025.csv`).

---

### 🔹 Task 2: Load & Explore in PySpark

**Q4.** Load the generated CSV into a PySpark DataFrame.  
**Q5.** Print the schema and identify which columns might need data type conversion.  
**Q6.** Display the top 5 rows for validation.

---

### 🔹 Task 3: Data Type & Date Transformations

**Q7.** Convert the `date` string column to a proper `DateType`.  
**Q8.** Add two new columns:
  - `holiday_month` (Extract month from the date)
  - `weekday_name` (Extract full weekday name, e.g., Monday)  
**Q9.** Which day of the week has the **most holidays** in 2025?

---

### 🔹 Task 4: Business Use Case - Holiday Analysis

**Q10.** Group holidays by `weekday_name` and count them.  
**Q11.** Suggest 2 insights HR can use based on weekday-wise distribution.  
**Q12.** Identify months with **more than 2 holidays**. What are they?

---

### 🔹 Task 5: Data Storage & Delivery

**Q13.** Save the transformed data in:
- JSON format
- Parquet format  
Ensure overwrite mode is enabled.

**Q14.** Mount or use the Azure Data Lake Storage (ADLS) path to write output files.  
**Q15.** Document the full ADLS path used and the type of container.

---


---


