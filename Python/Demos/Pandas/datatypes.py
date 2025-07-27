import pandas as pd

df=pd.read_csv("winemag-data-130k-v2.csv",index_col=0)

# #df.dtypes
# print(df.dtypes)

# # df.astype()
# df['points']=df['points'].astype('Int32')
# df['country']=df['country'].astype('string')

# print(df.dtypes)

# # pd.to_numeric()
# df['price']=pd.to_numeric(df['price'],errors='coerce')
# print(df['price'].head(20))

# # autmatic Type conversion
# df=df.convert_dtypes()

# # df.isnull() or df.isna()
# # Returns a DataFrame of booleans where True indicates a NaN.
# print(df.isnull().head(5)[['country','price','points']])
# print(df.isna().head(5)[['country','price','points']])


# # df.notnull() df.notna()
# # masked_df=df['price'].notnull()
# # print(masked_df.head(3)) # masking or boolean indexing
# print(df[df['price'].notnull()].head(3))


# # isnull
# print(df.isnull().sum())

# mask=df.isnull().any(axis=1)
# print(df[mask].head())
# #print(df.isnull().any(axis=1).head())

# # # fillna
# # df['price']=df['price'].fillna(df['price'].median())

# # print(df['price'].isnull().sum())
# # print(df['price'].head(35))
# print('original data price')
# print(df['price'].head(35))
# df['price']=df['price'].fillna(0)
# print('after modified')
# print(df['price'].head(35))

# print('original data')
# print(df[['country','price','region_1']].head(15))

# # df_ffill=df[['country','price','region_1']].copy()
# # df_ffill.ffill(inplace=True)

# # print('After Forward Fill')
# # print(df_ffill.head(15))
# print('original data')
# print(df[['country','price','region_1']].head(15))
# df_bfill=df[['country','price','region_1']].copy()
# df_bfill.bfill(inplace=True)
# print('After Backward Fill')
# print(df_bfill.head(15))



# # dropnda()
total_rows=len(df) # totl no of rows in original dataset
row_with_nulls=df.isnull().any(axis=1).sum() #calculate no.of.rows with  null values in any column
print(f"total Rows before Drop :{total_rows}")
print(f"Total Number of Rows with Nulls before Drop: {row_with_nulls}")
df=df.dropna()
print()
print('After Dropped')
print('\n After Dropping rows with Null')
print(f"Remaining Rows: {len(df)}")
print(f"Rows with Null after drop :{df.isnull().any(axis=1).sum()}")
print(f"Total Rows after dropped with null values {df.isnull().sum()}")

df.to_csv("winemad-data-without-null.csv")