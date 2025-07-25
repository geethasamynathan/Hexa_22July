import pandas as pd
import pyodbc

# Step 1: Load the CSV file
df = pd.read_csv('customers.csv')

# Step 2: Define the cleanup function
def clean_record(record):
    record['name'] = record['name'].strip().title()
    record['email'] = record['email'].strip().lower()
    return record

# Step 3: Apply map cleanup
cleaned_data = list(map(clean_record, df.to_dict(orient='records')))
cleaned_df = pd.DataFrame(cleaned_data)

# Step 4: Save cleaned data to a new CSV file
cleaned_df.to_csv('cleaned_customers.csv', index=False)
print("✅ Cleaned data saved to 'cleaned_customers.csv'")

# Step 5: (Optional) Write to SQL Server
try:
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=LAPTOP-0TBPBTEL\\SQLEXPRESS;DATABASE=pythondb;Integrated Security=True;Trusted_Connection=yes;')
    cursor = conn.cursor()

    # Create table if not exists
    cursor.execute("""
        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customers' AND xtype='U')
        CREATE TABLE Customers (
            id INT,
            name NVARCHAR(100),
            email NVARCHAR(100)
        )
    """)
    conn.commit()

    # Insert cleaned data
    for _, row in cleaned_df.iterrows():
        cursor.execute("INSERT INTO Customers (id, name, email) VALUES (?, ?, ?)", row['id'], row['name'], row['email'])

    conn.commit()
    cursor.close()
    conn.close()
    print("✅ Cleaned data inserted into SQL Server")
except Exception as e:
    print("❌ Failed to connect or insert into SQL Server:", e)