import pandas as pd
import matplotlib.pyplot as plt

# 1. 📥 Load CSV into DataFrame
df = pd.read_csv("Superstore.csv")
print("🔹 Preview of raw data:")
print(df.head())

# 2. 🧹 Clean column names & date formats
print(df.dtypes)
# print(f"Order_Date :{df['Order_Date'].dtype}") # to know Order_Date Column Datatype
df.columns = df.columns.str.strip().str.replace(' ', '_').str.replace('/', '_')
print(f"Order_Date :{df['Order_Date'].dtype}") 
df['Order_Date'] = pd.to_datetime(df['Order_Date'], format='%d-%m-%Y')
df['Ship_Date'] = pd.to_datetime(df['Ship_Date'], format='%d-%m-%Y')
# print(f"Order_Date :{df['Order_Date'].dtype}")

# 3. 💡 Fill missing Price with 1 (if exists)
if 'Price' in df.columns:
    df['Price'] = df['Price'].fillna(1)

# 4. 📊 Region & Category Profit Summary
# profit_summary = df.groupby(['Region', 'Category']).agg({
#     'Sales': 'sum',
#     'Profit': 'sum',
#     'Discount': 'mean'
# }).reset_index()
# print("\n✅ Region & Category Profit Summary:")
# print(profit_summary)

# # 5. 🏆 Top 5 Profitable Products
top_products = df.groupby('Product_Name').agg({'Profit': 'sum'}).sort_values('Profit', ascending=False).head(5)
print("\n🏆 Top 5 Profitable Products:")
print(top_products)

# # 6. 📈 Monthly Sales Trend
# df['Month'] = df['Order_Date'].dt.to_period('M').astype(str)
# monthly_sales = df.groupby('Month').agg({'Sales': 'sum'}).reset_index()
# monthly_sales = monthly_sales.sort_values('Month')

# # Plot Monthly Sales Trend
# plt.figure(figsize=(10, 5))
# plt.plot(monthly_sales['Month'], monthly_sales['Sales'], marker='o')
# plt.title('Monthly Sales Trend')
# plt.xticks(rotation=45)
# plt.xlabel('Month')
# plt.ylabel('Total Sales')
# plt.grid(True)
# plt.tight_layout()
# plt.show()

# # 7. 🌆 Top 10 Cities by Avg Order Value
# df['Order_Value'] = df['Sales'] / df['Quantity']
# city_avg_order_value = df.groupby('City')['Order_Value'].mean().sort_values(ascending=False).head(10)
# print("\n🌆 Top 10 Cities by Avg Order Value:")
# print(city_avg_order_value)

# # 8. ❌ Orders with Loss
# loss_orders = df[df['Profit'] < 0]
# loss_orders.to_csv("loss_orders.csv", index=False)
# print("\n✅ Loss-making orders saved as 'loss_orders.csv'")