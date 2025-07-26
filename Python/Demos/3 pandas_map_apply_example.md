
# 🐼 Pandas `map()` vs `apply()` for Data Integration – VS Code Example

This tutorial demonstrates how to use `map()` and `apply()` in pandas for data transformation using the `winemag-data-130k-v2.csv` dataset. You can run this end-to-end in **VS Code**.

---

## 📁 Folder Structure

```
project-folder/
│
├── wine_data_analysis.py
├── winemag-data-130k-v2.csv
└── transformed_winemag_data.csv  ← generated after execution
```

---

## ✅ Python Script (wine_data_analysis.py)

```python
import pandas as pd

# Step 1: Load the dataset
df = pd.read_csv("winemag-data-130k-v2.csv", index_col=0)

## ![alt text](image.png)
# Step 2: Show initial data
print("🔹 Initial Data Sample:")
print(df[['country', 'price', 'points']].head(5))

# Step 3: Map Country Names
country_map = {
    "US": "USA",
    "England": "UK",
    "South Korea": "Korea"
}
df['country_standardized'] = df['country'].map(country_map).fillna(df['country'])

# Step 4: Apply Price Category Logic
def price_category(price):
    if pd.isna(price):
        return "Unknown"
    elif price < 20:
        return "Budget"
    elif price < 50:
        return "Standard"
    elif price < 100:
        return "Premium"
    else:
        return "Luxury"

df['price_category'] = df['price'].apply(price_category)

# Step 5: Map points to grades
df['points_grade'] = df['points'].map(lambda x: 'High' if x >= 90 else 'Low')

# Step 6: Apply row-wise transformation to create a summary
def summarize(row):
    return f"{row['country']} - {row['variety']} - {row['points']} pts"

df['summary'] = df.apply(summarize, axis=1)

# Step 7: Show Transformed Columns
print("\n🔸 Transformed Sample:")
print(df[['country', 'country_standardized', 'price', 'price_category', 'points', 'points_grade', 'summary']].head(10))

# Step 8: Optional - Save to CSV
df.to_csv("transformed_winemag_data.csv", index=False)
print("\n✅ Transformed data saved to 'transformed_winemag_data.csv'")
```

---

## 🧠 What You Learn

| Method      | Description                                      |
|-------------|--------------------------------------------------|
| `map()`     | Use for simple element-wise operations, like replacing values |
| `apply()`   | Use for custom row/column operations with functions |
| `apply(axis=1)` | Apply function across entire rows for custom summaries |
| `to_csv()`  | Export results for further integration           |

---

## ▶️ To Run in VS Code Terminal

1. Open folder in VS Code
2. Place CSV file in the same folder
3. Run:
```bash
python wine_data_analysis.py
```

You’ll see printed output in the terminal and a new file `transformed_winemag_data.csv`.

---
