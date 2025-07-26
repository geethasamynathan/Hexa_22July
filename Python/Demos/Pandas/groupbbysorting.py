import pandas as pd

df=pd.read_csv("winemag-data-130k-v2.csv")

# # Groupby
# print(df.groupby('country')['points'].mean())

# #Group By Multiple Colummns
# print(df.groupby(['country','variety'])['points'].mean())

# # Groupig with multiple Aggreagetion
# print(df.groupby('country')['points'].agg(['mean','min','max','count']))


# # naming Aggregated columns
# print(
#     df.groupby('country').agg(
#         avg_points=('points','mean'),
#         total_reviews=('points','count')
#        ))

# # Filter with Group by
# print(df.groupby('country').filter(lambda x :len(x)>1000))


# # Apply the Logic 
# print(df.groupby('country').apply(lambda x:x[x['points']>95])[['country','points']])

# # Sort by column
# print(df.sort_values(by='points',ascending=False)['points'])

# # Sorting Multiple Columns
# print(df.sort_values(by=["country","points"],ascending=[True,False])[['country','points']])

# # Sorting After Grouping
# grouped=df.groupby('country')['points'].mean()
# grouped_sorted=grouped.sort_index(ascending=True)
# print(grouped_sorted)

# #Sorting Aggregated Results
# print(df.groupby('country')['points'].mean().sort_values(ascending=False))

#Flatterned the grouped result back
print(df.groupby('country')['points'].mean().reset_index())


