import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

#price_data = pd.read_csv('~/Desktop/price.csv')
price_data = pd.read_csv('./price.csv')
print(price_data.head())

price_data = price_data.fillna(0)

print(price_data.head())

def get_price_info():
    for index, row in price_data.iterrows():
        try:
            price = row['Total_Price']
            quantity = row['Quantity']
            price_of_a_unit = (price/quantity)
            print(price_of_a_unit)            
        except ZeroDivisionError :
            continue

get_price_info()

plt.bar(price_data.Things, height=price_data.Total_Price)
plt.title('Barplot of Things vs Total_Price')
plt.show()

    
def get_price_info1():
    price_of_a_unit_arr=[]
    for index, row in price_data.iterrows():
        try:
            price = row['Total_Price']
            quantity = row['Quantity']
            price_of_a_unit = (price/quantity)
            print(price_of_a_unit)            
        except ZeroDivisionError :
            price_of_a_unit=0
            continue
        finally:
            price_of_a_unit_arr+=[price_of_a_unit]
    return price_of_a_unit_arr

price_of_a_unit_arr=get_price_info1()
plt.bar(price_data.Things, height=price_of_a_unit_arr)
plt.title('Barplot of Things vs Price Per Unit')
plt.show()