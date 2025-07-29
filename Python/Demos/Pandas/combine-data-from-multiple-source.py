import pandas as pd
import sqlite3

df_excel=pd.read_excel("sales_excel.xlsx")

df_csv=pd.read_csv("sales_csv.csv")

df_json=pd.read_json("sales_json.json")

conn=sqlite3.connect("sales_db.sqlite")
df_sql=pd.read_sql_query("SELECT * FROM Sales",conn)

# print(f"\n Data from Excel {df_excel.shape[0]}")
# print(f"\n Data from csv {df_csv.shape[0]}")
# print(f"\n Data from Json {df_json.shape[0]}")
# print(f"\n Data from sqllite {df_sql.shape[0]}")

df_combined=pd.concat([df_excel,df_csv,df_json,df_sql],ignore_index=True)
print("\n combined data are below \n")
# print(df_combined)

df_combined["TotalAmount"]=df_combined['Quantity']*df_combined['UnitPrice']
print(df_combined.head())
