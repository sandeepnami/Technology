import pandas as pd
import requests
import time
from contextlib import redirect_stdout

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
    'cookie': 'defaultLang=en; _ga=GA1.1.336479484.1713945655; _ga_QJZ4447QD3=GS1.1.1714714127.4.0.1714714127.0.0.0; AKA_A2=A; _abck=E4B725D5404059D7A728735DAF0E7947~0~YAAQlG4/F0ShBUmPAQAAfLJZTQtCp0VIXSjPfNdZiAD83fpHq9o6L10EbQc+d8GVgyCmwOyIV793QZjP2n+cz8NefGQIoYoK+RBqkJRBT7C5mM6nYXO7o7zl8+TV1XN7notVsUtCcgd+dnOigdNsJL8M1r3ks4iM/SBl57pDmSKuXKCRNGPJG6xZ1pTVJ93eW1wHs7bNQeDUGWP0Ka5ol4FTv7RdlJg10OIR5qaLFY2S+7wSHSeS9p/h6q9D5R06AcaJLC+pIAVTiwKK7A9ORmu6M+vw4G90/22+lTDOzIGzmOrzv3/wO7Nmn4MLqM3IClFxtCp3ZDqmo3RBJmKEo1/jDk2qz0F4EoFiU/BF3cnYjm61xA/ZzvDA1Nqwco2fp1t2A2GRJVM5EchiDz6EjUvCqvLIhTw1IJs=~-1~-1~-1; nsit=ZDNnNSG9yD7cIMqfiihOEdKv; nseappid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGkubnNlIiwiYXVkIjoiYXBpLm5zZSIsImlhdCI6MTcxNDk5MjE5OCwiZXhwIjoxNzE0OTk5Mzk4fQ.EyZ4ttAg7rMqICIKjf86d403afdN1m6MOXT4US2ran4; bm_mi=862AEC72534E7AB4FB4EBCC0F065E794~YAAQXXxBF5s1c0mPAQAAAzSATRdU0vuJU0RF72/d3Vat0aaBlxLybOYCH21L440vzw/D8ww/Lj2mDkakD9Z0jaW0z7o5pLBBrfmuW0+qu6lKDZ3AHBX6EZINwl6JLRbG3+aS2/9XcZseejDsENRiKMjK8Yluz/rTUSMV+hpv44bHugRPb1LTkf3oCMDK3rPUAhjrkzWf1MBFc7GTWC3bUsWBTP2nx6eZ44wkOcv92WFjwertiX7Q1d9jxP0JlOdNz+Nb76yH6MYm36KbhdklcDKwXFbzTbkrCrEOBSlAUE6lkdVXbvwnQjS87du159rDFlHHU7cIsCCxsEeu~1; bm_sz=24BC298D7964561366DABC043FE2B9F9~YAAQXXxBF501c0mPAQAAAzSATRdIn4XWvfhp9sSS4ncsrTAHH+/5X4KhN8VBUleZ9XUI4YKDvBoV4uKrV2x1E4C+L2yV+dxBcexNwB/LQ1dDnv8YtRsLc0Er+m7kOvY6orDN+sPAFIqSfh70Kv5sibo9L1JC0oKVi1s5l/DSrfOhVHRultDgYcdHkTmXuzmaa9BnHKbr6kbine4y/D0ZuCWjTDTAEMOosaIn2VMkX2qPBMSIKXbf4bGxapvaDoKok30iNlCwDdQEBRgk5ModEuhs4QTr4dLM/No5pxNGS97BlNgpjemkbvCVhkjrm+rRWhjl3XDyb1keROjZRjtCHjDGGObFlOhCRKw0Y6eMKvvuNKejDMdgU7X/DYe+LPriVZ9Z2RXFSesy49PBt5VQDJoUpBPcR8qMHmUXa44c6j17edpIHo78XDM=~3159353~3490116; ak_bmsc=F50519E1538F6276DD79CC2248886004~000000000000000000000000000000~YAAQXXxBF3U2c0mPAQAAtTeATRdHVzAzw/EzVUmW4JAj57Se3x2rA53eirrZ7Qci7JdOEB0UvbJLBBUbIX8A2MlLhL+1tMyY3Yr7hLn9SFSuoafBJ9YwpYqGLneWZMoUzEmfllUZA2JK+9liMcUuJ8GYiAukUuqW+369Yr6Y+7lmxLIa7w4n/qIu+iZ/C1GLBE7//eaZNGmdrwGqdULkKRDGtKpyOIbPItOule+me0lseCHyIXqeC7btRc4blNf3trx2n3ePKZDxc99O2D2W6/1l9Iwgwk+2dz9ihQxA9Nmk3Nau61VS+P95w45Mg45MNp0iGoEcRwrxwX19HM2Mhj7Md1epdfPx2SbWHcLRFz2khHZfZpzRkfnbX1iSISCJx40AfuhND2g98oQwj7ytl6fb3iJBzWBKEopzzIJCbNbm/OegBqBxgGHFTsk8Uy4yx0949PfIBBIkXD9BLvv5jYbzDelHhdo1LU4T8P9geUkfj8Qziv28j4+QyMsyZYQNsAvp; RT="z=1&dm=nseindia.com&si=f72572b7-2bad-4417-91cd-7acb243b12df&ss=lvueq42e&sl=0&se=8c&tt=0&bcn=%2F%2F684d0d43.akstat.io%2F"; _ga_87M7PJ3R97=GS1.1.1714992197.14.1.1714992199.0.0.0; bm_sv=209B1490E7ADE3B86F77C3E609F80557~YAAQXXxBF/M2c0mPAQAAMjuATRdu/8mgxMa5e4a7pW61yKzERek0o+ox7ZfgJb/2IUd7IAKJ5b8cowLJeMZf5yE2S3oTDXZyeVJo/ol2PmzAAsXhH1jgZF4mmT/0hb7kove+rtpYTLPKpLhylW2mT71nxqNF9C96ThwKEZHirxVQI9/SXZhQyGeLUP1VpsaEJ05oa5jMjZBZOZeqPHhLq/t/tABC/EQM853FDAANyyEHSur1GNTB0lpKQ2sr/+sIZho=~1'
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
    oi_list_dict = {'ce_oi':ce_oi,'pe_oi':pe_oi}  
    
    return oi_list_dict


def cal_oi_supp(oi_list_dict,supp_list_dict):
    # print(oi_list_dict)
    ce_supp = (oi_list_dict[-1]['pe_oi'] - oi_list_dict[-1]['ce_oi'])*100/ oi_list_dict[-1]['ce_oi']
    pe_supp = (oi_list_dict[-1]['ce_oi'] - oi_list_dict[-1]['pe_oi'])*100/ oi_list_dict[-1]['pe_oi']
    ce_supp, pe_supp = round(ce_supp,2), round(pe_supp,2)
    supp_list_dict.append({'ce_supp':ce_supp,'pe_supp':pe_supp})
    
    return supp_list_dict


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
        
        with open(str(out_files[index])+'.txt', 'w') as f:
            with redirect_stdout(f):
                for row in supp_list_dict_array[index]:
                    print(row)
    
