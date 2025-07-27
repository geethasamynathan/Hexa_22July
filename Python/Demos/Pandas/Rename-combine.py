import pandas as pd

df=pd.read_csv("winemag-data-130k-v2.csv",index_col=0)

# print("Initial Columns",df.columns.tolist())

df.rename(columns={
   'country':"Country",
   'description':"Description",
   'designation':"Designation", 
   'points':'Points', 'price':"Price", 'province':"Province", 
   'region_1':"Region", 'region_2':"SubRegion", 
   'taster_name':"Reviewer", 'taster_twitter_handle':"Twitter", 
   'title':"WineTitle", 'variety':"Grape", 'winery':"Winery" 
},inplace=True)

# print("\n\n")
# print("Renamed  Columns",df.columns.tolist())

df['Wine_Overview']=df['WineTitle']+" | "+df["Grape"]+" | "+df['Winery']


# print(f"\n  Total Columns: {len(df.columns)}")
# print(f"\n {df['Wine_Overview']}")


df['Country']=df['Country'].replace({
    "US":"United States of America",
    "England":"United Kingdom",
})

# print(df['Country'].head(10))

high_rated_wines=df[df['Points']>90]
# print(high_rated_wines[['Country','WineTitle','Points']].head(20))

# print(f"\nBefore fillna null rows count {high_rated_wines.isnull().sum()}")
# high_rated_wines['Price'].fillna(1,inplace=True)

# print(f"\n After fillna null rows count {high_rated_wines.isnull().sum()}")

df['Price'].fillna(1,inplace=True)
# print(df['Price'])
df['PriceCategory']=pd.cut(df['Price'],bins=[0,20,50,100,500,1000],
                           labels=['Budget','Standard','Good','Premium','Luxury'])

# print(df[['Country','Price','PriceCategory']])

print(df.dtypes)


df.to_csv('new_winemag.csv',index=False)