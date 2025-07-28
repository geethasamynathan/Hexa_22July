import requests
import pandas as pd
from datetime import datetime
import matplotlib.pyplot as plt

url="https://open.er-api.com/v6/latest/INR"
response=requests.get(url)
data= response.json()

if data['result']!='success':
    raise  Exception('API call failed')

timestamp=data['time_last_update_unix']
base_currency=data['base_code']
rates=data['rates']

major_currencies=['USD','EUR','GBP','JPY','AUD']
inr_per_currency={}

for currency in major_currencies:
    if(currency in rates and rates[currency]!=0):
        inr_per_currency[currency]=round(1/rates[currency],2)
        
updated_at=datetime.utcfromtimestamp(timestamp).strftime('%Y-%m-%d %H:%M:%S')

df=pd.DataFrame(list(inr_per_currency.items()),columns=['Currency','Inr_Equivalent'])
df['Base_Currency']=base_currency
df['Updated_At']=updated_at

print(df)

plt.figure(figsize=(10,6))
plt.bar(df['Currency'],df['Inr_Equivalent'],color='blue')
plt.title('Indian Value of Major Currencies')
plt.xlabel("Currency")
plt.ylabel("Value in INR")
plt.grid(axis='y',linestyle='--',alpha=0.8)
plt.tight_layout()
plt.show()
