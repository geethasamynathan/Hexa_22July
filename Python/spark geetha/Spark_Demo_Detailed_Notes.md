# 📘 Spark Demo Steps – Detailed Explanation

## Step 1: Install openpyxl
```python
%pip install openpyxl
```
**Explanation:** Installs the openpyxl package used to read Excel (.xlsx) files using pandas.

---

## Step 2: Restart Python Kernel
```python
dbutils.library.restartPython()
```
**Explanation:** Restarts the Python environment to ensure new libraries are loaded properly.

---

## Step 3: Read Excel File with Pandas
```python
import pandas as pd
excel_path="/Volumes/workspace/default/myvolume/Financial Sample (2).xlsx"
pdf=pd.read_excel(excel_path, engine="openpyxl")
pdf.head()
```
**Explanation:** Loads the Excel file into a Pandas DataFrame. 'head()' shows the first few rows.

---

## Step 4: Convert to Spark DataFrame
```python
df = spark.createDataFrame(pdf)
display(df.head(5))
```
**Explanation:** Converts the Pandas DataFrame to a Spark DataFrame.

---

## Step 5: Print Schema
```python
df.printSchema()
```
**Explanation:** Displays column names and data types in the Spark DataFrame.

---

## Step 6: Filter Sales > 5000
```python
df.filter(df[' Sales'] > 5000).show()
```
**Explanation:** Filters rows where the Sales value is greater than 5000. Note the space before 'Sales'.

---

## Step 7: Clean Column Names & Filter Again
```python
df = df.toDF(*[col_name.strip() for col_name in df.columns])
df.head(5)
df.filter(df['Sales'] > 1000).show()
```
**Explanation:** Strips whitespace from column names and filters rows where Sales > 1000.

---

## Step 8: Check for Null Values
```python
from pyspark.sql.functions import col
null_count = df.filter(col('Sales').isNull()).count()
if null_count > 0:
    print(f"Sales column has {null_count} null values")
else:
    print("No null values")

null_country_count = df.filter(col('Country').isNull()).count()
if null_country_count > 0:
    print(f"Country column has {null_country_count} null values")
else:
    print("No null values")
```
**Explanation:** Counts and prints null values in 'Sales' and 'Country' columns.

---

## Step 9: List Distinct Segments
```python
segments = df.select("Segment").distinct().collect()
print(segments)
```
**Explanation:** Retrieves distinct values from the 'Segment' column.

---

## Step 10: Add Profit Margin Column
```python
from pyspark.sql.functions import col, round
df = df.withColumn("Profit_Margin", round(col("Profit") / col("Sales"), 2))
df.select(["Profit", "Sales", "Profit_Margin"]).show()
```
**Explanation:** Adds a new column 'Profit_Margin' calculated from Profit/Sales.

---

## Step 11: Drop Duplicates
```python
print(f"Before dropping duplicates: {df.count()}")
df = df.dropDuplicates()
print(f"After dropping duplicates: {df.count()}")
```
**Explanation:** Removes duplicate rows and shows the record count before and after.

---

## Step 12: Group By Country
```python
df.groupby('Country').agg({'Sales':'sum','Profit':'sum'}).show()
```
**Explanation:** Aggregates total sales and profit for each country.

---

## Step 13: Top 5 Countries by Sales
```python
df.groupby('Country').sum('Sales').orderBy('sum(Sales)', ascending=False).show(5)
```
**Explanation:** Shows top 5 countries based on total sales.

---

## Step 14: Avg Profit by Segment
```python
df.groupby('Segment').avg('Profit').show()
```
**Explanation:** Calculates average profit per segment.

---

## Step 15: Monthly & Yearly Trends
```python
from pyspark.sql.functions import month, year
df = df.withColumn("Month", month(col("Date")))
df = df.withColumn("Year", year(col("Date")))
df.groupby("Month").sum("Sales").orderBy("Month").show()
df.groupby("Month").sum("Profit").orderBy("Month").show()
df.groupby("Year").sum("Sales").orderBy("Year").show()
df.groupby("Year").sum("Profit").orderBy("Year").show()
df.groupby("Segment").sum("Sales").orderBy("sum(Sales)", ascending=False).show()
df.groupby("Segment").sum("Profit").orderBy("sum(Profit)", ascending=False).show()
```
**Explanation:** Extracts month and year from 'Date' column and generates time-series reports.
