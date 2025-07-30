`%pip install openpyxl`

```python
dbutils.library.restartPython()
```

```python

import pandas as pd
excel_path="/Volumes/workspace/default/myvolume/Financial Sample (2).xlsx"
pdf=pd.read_excel(excel_path,engine="openpyxl")
pdf.head()
```

```python
df=spark.createDataFrame(pdf)
display(df.head(5))
```

```python
df.printSchema()
```
```python
df.filter(df[" Sales"] > 5000).show()
```

```python
df=df.toDF(*[col_name.strip() for col_name in df.columns])
df.head(5)
df.filter(df['Sales']>1000).show()
```

```python
# Count If Null values are there in Sales column
# from pyspark.sql.functions import col,sum

null_count=df.filter(col('Sales').isNull()).count()
if null_count>0:
    print(f"SAles Column has {null_count} null values")
else:
    print("No null values   ")
null_country_count=df.filter(col('Country').isNull()).count()
if null_count>0:
    print(f"Country Column has {null_country_count} null values")
else:
    print("No null values   ")
```

```python
# df.select("Segment").show()

segments=df.select("Segment").distinct().collect()
print(segments)
# df.select("Country").show()
```

```python
from pyspark.sql.functions import col,round
df=df.withColumn("Profit_Margin",round(col("Profit")/col("Sales"),2))
df.select(["Profit","Sales","Profit_Margin"]).show()
```

```python
# Drop duplicates
print(f"Before dropping Duplicate {df.count()}")
df=df.dropDuplicates()
print(f"After dropping Duplicate {df.count()}")
```

```python
df.groupby('Country').agg({"Sales":"sum","Profit":"sum"}).show()
```

```python
df.groupby("Country").sum("Sales").orderBy("sum(Sales)",ascending=False).show(5)
```

```python
df.groupby("Segment").avg("Profit").show()
```

```python
from pyspark.sql.functions import month,year
df=df.withColumn("Month",month(col("Date")))
df.groupby("Month").sum("Sales").orderBy("Month").show()
df.groupby("Month").sum("Profit").orderBy("Month").show()
df.groupby("Year").sum("Sales").orderBy("Year").show()
df.groupby("Year").sum("Profit").orderBy("Year").show()
df.groupby("Segment").sum("Sales").orderBy("sum(Sales)",ascending=False).show()
df.groupby("Segment").sum("Profit").orderBy("sum(Profit)",ascending=False).show()

```