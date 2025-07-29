import pandas as pd
import pyodbc

conn=pyodbc.connect(
    'DRIVER={ODBC DRIVER 17 for SQL Server};'
    'SERVER=LAPTOP-0TBPBTEL\SQLEXPRESS;'
    'DATABASE=Hexa_22jul_DB;'
    'Trusted_Connection=yes;'
    'TrustedServerCertificate=true'
)

query="SELECT * FROM CustomerOrders"
df=pd.read_sql(query,conn)

#print("📝Raw data")
#print(df.head())

# Basic Data Cleaning
df['CustomerName']=df['CustomerName'].str.strip().str.title();

#print(df['CustomerName'])

mask=df['Email'].fillna('').str.contains(r'[A-Z]')
upper_case_emails=df[mask]

print(upper_case_emails.head(10))

df['Email'].str.lower()
df['Quantity'].fillna(1,inplace=True)
df['PricePerUnit'].fillna(df['PricePerUnit'].mean(),inplace=True)
df['OrderDate'].fillna(method='ffill',inplace=True)


# duplicates=df[df.duplicated(keep=False)]
# print("\n Duplicated Records")
# print(duplicates)


df_cleaned=df.drop_duplicates();
duplicates=df_cleaned[df_cleaned.duplicated(keep=False)]
print("\n After Removed Duplicated Records")
print(duplicates)

df_cleaned['Total Price']=df_cleaned['Quantity']*df_cleaned['PricePerUnit']

print(df_cleaned.head())

df_cleaned.to_csv("Cleaned_customer_Orders_Data.csv")
