"""
    V2.0 : Python is used to fetch live options data instead of Excel Power Query
    V2.1 : added time to the output file
"""
import pandas as pd
import requests
import time
from contextlib import redirect_stdout
import pygame
from datetime import datetime

iterations = 300
refresh_rate = 1 * 60 # 2 minutes
expiry = "09-May-2024"
nifty_range = [22500,22600]
no_of_ranges = 3
columns = ['strikePrice','expiryDate','underlying','openInterest','changeinOpenInterest','lastPrice']

get_url = "https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY"
headers = {
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'en-US,en;q=0.9',
    'referer': 'https://www.nseindia.com/option-chain',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
    'x-requested-with': 'XMLHttpRequest',
    'cookie': 'defaultLang=en; _ga=GA1.1.336479484.1713945655; _ga_QJZ4447QD3=GS1.1.1714714127.4.0.1714714127.0.0.0; nsit=D_GpBaJvQ6GtSN_09pfX425F; AKA_A2=A; _abck=E4B725D5404059D7A728735DAF0E7947~0~YAAQVnxBFzuzwEyPAQAA0n4SUQtbOtpSRohPWNs+AfisV/4A3bIFU6vrDuU1YJuuLJFWtnqRRFy4lfPqgpASsUSb1kFKA8MVI/1dNGUHbF/vAnZTabuwkL75OTLvnn5ML2BWFKR8ti+wMaz094VyPW7dHorSqUYouy69cOuqUyvRTSPjdpNrXhvd71AWhUZ3HQnZ1M1kg/NgTVRJILdfcNUnAurPVzL+My1IAhbTdjkvLdo+sNddvv73oZdeF+ejiOmPYKgAP6obWhQxs7vfZRSWW4nUUTItrWO4c8YTjaeiT+D+t4HEsCwNH6UkHLq0iYN2cshuJstjeTEG5JKS24Aqn9lw0or1Ctt+FbEUnjukGswVQ+3ryJtUdFtTgDRcrR9OAM9AiickFwcwBZ8Upozd+tV9XlxnO50=~-1~-1~-1; bm_mi=EC14150D2471BBC2EEECFAA053AC8636~YAAQVnxBFwS2wEyPAQAAi5ASUReu5Uy9Sbo0oQM8+rQOz/6H0E6kZptTxI4U0NdMrKMTbJcJgNuxD6l+KB6ytvhhvgDMCU9g7002LvsCR26/VbQuLmoo/LNAYPOaeiW4l47gtsFapJenUVCEyzzoh+QXfahJ4aUM9mk3Df6jzuIsLUadQQHbYS5k7+wxR8/R68MgaCjRvP9z0fktD+L0y93R30VGgcnEQ1byqsMOjWw4a1TCDSanP9Fl5hWTg8pFihlMTB2shCUKy2MRlWvXVc3NKx36zuK2e8zYx3O/HcosYOYOsF5Grsz9eQuMqsZ6ig4c0m7Grp+sLe1x~1; ak_bmsc=87610A74C109FDB276EBD5B5501D781C~000000000000000000000000000000~YAAQVnxBF9W2wEyPAQAAo5QSURe4ipprJGvYyxWnojS59NEqGbX59eMPfE1FAbqd1b9+Ws6X/TukdD8XsvqupU5jcqez1yeKVfBtVL0c92tcSDbHdWBxT2LUoGcZd/eQ+oYQ5bkeGEIKIzeUUhXfAubY04QXrihDmLUduOqh0ShuyemaN1Hqo09qNkBeA9mTfazgcorE1x7cjbacVa/cS5EzF0Urp6BnByKdARGyhpHpT/UUHQ3LeY8+RR1UegIpSsnQFVvh9DOzvmql00MegrUHsAMqailhD3HSQZPshj/cEIan9a7aHCwd++pv0yOP0BnHVXXP5nvQldR/26CeR44Ec5O2NNExGuLX9CWZVO8dya7PkXnExcUIsI3nYA7Wsgnq73FDQ1EE+Z94kDqCF+1QwmzAe3V94kjkzrzNG6Xh2FWFDSxDrVvIJB2xRC0VYuHKQr8sE2oQHTPKIyQEQjqjbSon5NY+PN61XliKrUl23Lsm8MQBg/boMvYm; nseappid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGkubnNlIiwiYXVkIjoiYXBpLm5zZSIsImlhdCI6MTcxNTA1MjE1MywiZXhwIjoxNzE1MDU5MzUzfQ.KSeTFETW0jCQROuTHKcszn1IYXD1bcJHAOPFDUw7H00; bm_sz=8E5153A594A1235C81429263AB142033~YAAQVnxBFwfLwEyPAQAAJwoTURdGPyv/IWHcFxPIsuH4uFHRBNCO6KeAmbIYM/iQbHcCyBkHx+82ZjLefT36BaGkkqgOdCHmlX7zB/XLog62QDtLuKvFHK/YsUDT7FvuuMo6WQmMwX/g3nXqKqHd86ML0chXfdbuiLzN+KRwK9VFUUzXMvtuI2CFRUs9kmkgKOuNBK3EEEKQCITCqhsdKld2mVTErL+gFHXlQ5AXfVuNYLOpQXKZtSkOGp1AmAuMgOEsuTJP3J7G0cDeJPdiNYF0h0rRMeKFyWEIZrCET3bom1+jPwHbH3MzYyRxnLaofARtBmJjAXKoxdZjH44ItRotgIfDxIvC5fxft+aFsrGDyVw8eTpLJ/KRW/ZEYWpbVJNl+RUKR8ygnhIz7mX0+CrftQO46K3QZg==~3687478~4534854; RT="z=1&dm=nseindia.com&si=f72572b7-2bad-4417-91cd-7acb243b12df&ss=lvvtqyja&sl=2&se=8c&tt=2br&bcn=%2F%2F684d0d4c.akstat.io%2F"; _ga_87M7PJ3R97=GS1.1.1715052118.16.1.1715052153.0.0.0; bm_sv=F3439E6A14222F75DB4597A5796B7A77~YAAQVnxBF6bLwEyPAQAAEg4TURcRqPonDFPnnymzv5uucfo3X8tNeNb8WBz9Ef5BjyQ1YXXHzXkhFQ/eYog5dM+yWlT7NtC0nh1JeJbuAmX+7wAVsOgjpExgrSSknMcu7o81F2a1XtHcEP8pIAbV1d+NV9JMzWrxIolnBmCFmsxhBsEbq1MG2ChSAyXrfat2ryZDq8hbs+1OfKXSUuNiVcjTodsZXZ65Jx+BUV3abVjtnnc+2Pf5e88FlDxpwa9Ze9hj~1'
}



## Fucntions
def calc_oi(nifty_range = nifty_range, expiry_date=expiry):
    response = requests.get(url=get_url, headers=headers)
    # print(response.json())
    nifty = pd.DataFrame(response.json()['records']['data'])
    nifty.dropna(inplace=True)
    nifty_columns = pd.DataFrame()
    
    # print(nifty['CE'])
    for column in columns:    
        nifty_columns['CE-'+column] = nifty['CE'].apply(lambda x: x.get(column))
        nifty_columns['PE-'+column] = nifty['PE'].apply(lambda x: x.get(column))
    # print(nifty_columns.head())
    
    nifty_columns.set_index(['CE-expiryDate'],inplace=True)
    # print(nifty_columns.head())
    
    current_expiry = nifty_columns.loc[expiry_date]
    #strikeprice is same for Calls and PUTS
    current_range = current_expiry[(current_expiry['CE-strikePrice'] >= nifty_range[0]) & (current_expiry['CE-strikePrice'] <= nifty_range[1])]
    ce_oi = current_range['CE-openInterest'].sum()
    pe_oi = current_range['PE-openInterest'].sum()
    
    current_time = datetime.now().time()
    formatted_time = current_time.strftime("%H:%M")
    oi_list_dict = {'time':formatted_time,'ce_oi':ce_oi,'pe_oi':pe_oi}  
    
    return oi_list_dict


def cal_oi_supp(oi_list_dict,supp_list_dict):
    # print(oi_list_dict)
    ce_supp = (oi_list_dict[-1]['pe_oi'] - oi_list_dict[-1]['ce_oi'])*100/ oi_list_dict[-1]['ce_oi']
    pe_supp = (oi_list_dict[-1]['ce_oi'] - oi_list_dict[-1]['pe_oi'])*100/ oi_list_dict[-1]['pe_oi']
    time = oi_list_dict[-1]['time']
    ce_supp, pe_supp = round(ce_supp,2), round(pe_supp,2)
    supp_list_dict.append({'time':time,'ce_supp':ce_supp,'pe_supp':pe_supp})
    
    return supp_list_dict

def play_sound():
    pygame.mixer.init()
    pygame.mixer.music.load('wow.mp3')
    pygame.mixer.music.play()
    time.sleep(5)
    pygame.mixer.music.stop()
    pygame.mixer.quit()

#Intialisation
nifty_range_array,out_files, oi_list_dict_array,supp_list_dict_array = [], [], [], []
for i in range(-no_of_ranges//2+1,no_of_ranges//2+1):
    nifty_range_array.append([nifty_range[0]+i*100,nifty_range[1]+i*100])
    out_files.append(nifty_range[0]+i*100)

print(nifty_range_array)


#First run
for i in range(no_of_ranges):
    supp_list_dict_array.append([])
    oi_list_dict_array.append([])
    oi_list_dict_array[i].append(calc_oi(nifty_range = nifty_range_array[i]))
    
    
for i in range(iterations):
    time.sleep(refresh_rate)
    
    for index in range(no_of_ranges):
        # print(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry))
        # print(f"oi_list_dict_array[index] = {oi_list_dict_array[index]}")
        oi_list_dict_array[index].append(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry))
        # print(f"oi_list_dict_array[index] = {oi_list_dict_array[index]}")
        supp_list_dict_array[index] = cal_oi_supp(oi_list_dict_array[index],supp_list_dict_array[index])
        
        if index == 1:
            print(supp_list_dict_array[index][-1])
            
            #Check if support change is more than 10% in last 10 minutes
            if len(supp_list_dict_array[index]) > 10:
                change_pe = abs(supp_list_dict_array[index][0]['pe_supp'] - supp_list_dict_array[index][-10]['pe_supp'])
                change_ce = abs(supp_list_dict_array[index][0]['ce_supp'] - supp_list_dict_array[index][-10]['ce_supp'])
                if change_pe > 10 or change_ce > 10:
                    play_sound()
                    
        with open(str(out_files[index])+'.txt', 'w') as f:
            with redirect_stdout(f):
                for row in supp_list_dict_array[index]:
                    print(row)
    
