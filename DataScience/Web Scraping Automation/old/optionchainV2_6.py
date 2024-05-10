"""
    V2.0 : Python is used to fetch live options data instead of Excel Power Query
    V2.1 : added time to the output file
    V2.2 : added retry for 5min to fetch option chain
    V2_5 : added cookies function
"""
import pandas as pd
import requests
import time
from contextlib import redirect_stdout
import pygame
from datetime import datetime

max_retries = 30
request_timeout = 15 # seconds
iterations = 300
refresh_min = 1 # minutes
refresh_rate = refresh_min*60 # seconds
sound_path = r'C:\Users\namis\OneDrive\Professional\Technology\DataScience\Web Scraping Automation\wow.mp3'
expiry = "09-May-2024"
nifty_range = [22400,22500]
no_of_ranges = 3
columns = ['strikePrice','expiryDate','underlying','openInterest','changeinOpenInterest','lastPrice']
nifty_columns = pd.DataFrame()

get_url = "https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY"
headers = {
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'en-US,en;q=0.9',
    'referer': 'https://www.nseindia.com/option-chain',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
    'x-requested-with': 'XMLHttpRequest',
    'cookie': 'defaultLang=en; _ga=GA1.1.336479484.1713945655; nsit=1uqKrsd5a9g4fOOe4giUtmnC; AKA_A2=A; bm_mi=E440B45B7ECD82225C6DFB9FC7B7A953~YAAQVnxBF9k4Ak2PAQAAsm/zURd1U3RZpYp3FfbBIH43HkSEIvZElHFDnHbA3UfNMFo3jXMi25Z8U8WGmhbarc/2Ido+nuhZ0Xp2H5vtl+kczLOKaONyHwZjmciyeaPWeJAyJabcWa02dihiiTVh/Wllgs253II9+TmrGfGgX9mko7fqLXYFtA711yn4A6vQsrJR8LsWQNdz9K2wvYBqQo5DnA2kO6PoC0A7YfzqqJyIhiaKdPVuE7BXuviPLuBdwphuq1CWGZK1OJX76Tb+7huCY5KSAKAF6NVZnN8CNOBo4slDkCRmfFJ928krWn8hYTTJXTzk/Tehw/VD~1; ak_bmsc=ED50B2A7D4F89713C4F6F409384F36E8~000000000000000000000000000000~YAAQVnxBF3A6Ak2PAQAAXnTzURdFxoQCuTPhPBHjWtWfMZMtU/6P/VMGaE8V0gNBSpBX4LKLU1pWaEDPYe4wcd0Ur8K4mgoXKx+inT8+qy9aKhov3fuuZSwpg1gqc2efvCuo0VKV2WT75QIp6fMaf0k5qhvhkGRDtBU6fxFPCOSQ2djhCwasKFlUalYOTd7XlA1QRQCGBGLFM9ZxvK5gHAKVoi8V9H+WhBMHBK3ChcuCuVeI3TnsTRkQyTPlrPRw/9PTO5K1BkX9iOM0knxlweT0BhLAgiMBOqB3fCvvPEUcDr9fAd8h7Dh8HwIFH/10tLtGQfxjDozr5Yo8G7jIumHz4eiHeZVK6qJo2btT3ao25ChVvulCPmQFFsMEGA8+uXxz/kTQFFJm4x9eZuZfdzf5fdkeDB1+UQbqpE4Am3O0aRgwOTz/uYDf6x7uq5o6eq9Nz/2E0fyaM/YQozVj+sG5rHyEvogE+nn6FeNsuPNI8mSOxV7HGK3zwFdK; _ga_QJZ4447QD3=GS1.1.1715067483.8.0.1715067483.0.0.0; nseappid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGkubnNlIiwiYXVkIjoiYXBpLm5zZSIsImlhdCI6MTcxNTA2NzQ4OSwiZXhwIjoxNzE1MDc0Njg5fQ.tBzlv6j5KIFP1M6eX63rQnJfYaJh549tqdae6Uy5pCY; bm_sz=031B6A4324F725E2D1CCD3E0927F293F~YAAQVnxBF8hHBU2PAQAAdQ39URct6QH3DTDhRu8LtWQOnhGqlDLpYqYzktwRp9LG8dMjDNSMuVqXz3loLNNaPLYSO2Q1eBgbwQsrNS2i5Z5rBywenFXKbqj/DD+4oBT7TbjFWD4Vbb7DGC0ZAljuCKiSEk5aLd3jxRPgAhg/+v5sP9nx8cG4f4vhcsxirJ0+eT/WgdbGzyM8puakIzK9L4L+JJTTi4gIVOBMe9NcD2Ft8p0Th2uJdeeqeEwUM1IF0z7P8ToV37tF8DYhfd8019KCYVygKdwDMZ6+AuaQFQ0kNJl1aPa7iaPTYXCrjaHyFEop2idsbKgHrpPPB43n6bybhM0C7hT7nzTjNvKUOMlWmzJiP7eyQuGJDf6B3/NOsc2u+ia2J0W9KjCuBRbqbJRov/MyDCQ8VbSF0DmpDYDp7APkuXlLoOQ6AWAc677+H6l78xw6G1wRTZiE6iKfixKY+HeyaLtrwBFo/dc7EtCML1ME0mYP8JbXEWOjgumqRxdwnGVLsSJgJ6atOWaQ4bd7bflX9CExZUu+prqm2qck750Ihzs7r7ZRUnwdgx82zJmQWmWenVMUfGk=~3486530~3159876; RT="z=1&dm=nseindia.com&si=f72572b7-2bad-4417-91cd-7acb243b12df&ss=lvw2wb3s&sl=0&se=8c&tt=0&bcn=%2F%2F684d0d41.akstat.io%2F"; _ga_87M7PJ3R97=GS1.1.1715066859.19.1.1715067490.0.0.0; _abck=E4B725D5404059D7A728735DAF0E7947~0~YAAQVnxBF1dJBU2PAQAAgBH9UQv9bJEs5RS3aNTlXlwBLP+HwwAyPFfoOlL1RsUY8/RM+N8ADKhwe/+QiB8pmtvfaxyZovcvdTTfWV7KmmyYvu0B+hQnxsG33LjWPmpYKELyVdoqttJruHre1zuMOJTWG5Vm0y22m6SymkM+dx443bBODz9AtfpvicSS2V4CpWOSmrxAAauHgZ0IDPBCAoUHPvqgnOV3tK1gFH8tni3VNc+vNhZjOkEr1QC9tRfz8iXUja2b2jilvZlooMqzpiN86NjiOb12cxK/jXqsTlpK93w/HT4dsSaLWQrxPTuCfYhxzcGJZr2jHQ645fGBKoVPIUfxPIeIaBzQnKvqU91PsvYm0McUdIwCUlSXxTUm~-1~-1~-1; bm_sv=74EDD791E9FCE8A807E86E5837830ABC~YAAQVnxBF1hJBU2PAQAAgBH9URfyrFItMugvq0FOf8HiS4A6E12tjVPAywroSxetMK+chK/uXVHB+BrOcr8dY28iiGzLQk2WsYAorLhF3q1rc3gdaUyXYTSVUXptBljfWzc+DtuPyPrdTuK+SCIqJzj64yzcmN8Sp2LS7caocswFSn3wn/QECZubFM/4RajYnRZZDo1E2tjxCZ3A9sTapfpEa6PyZPQMLpyM+2XNJWrLLN1jwGtJOS3qRyF+b407RB0e~1'
}



## Functions
def fetch_cookies(input_cookie=headers.get("cookie")):
    # Send a GET request
    ## check this url once https://www.nseindia.com/option-chain
    response = requests.get(url=get_url, headers=headers, timeout=request_timeout)

    # Get the cookies from the response
    cookies = response.cookies

    # Print the cookies
    for name, value in cookies.items():
        print(f'{name}: {value}')
        if(value == input_cookie):
            print('Cookie is same')


def fetch_live_data(input_cookie=headers.get("cookie")):
    # Retry requests.get in case of failure
    # print('inside function fetch_live_data')
    retries = 0
    while retries < max_retries:
        try:
            response = requests.get(url=get_url, headers=headers, timeout=request_timeout)
            break
        except requests.exceptions.RequestException as e:
            print(f"Request failed. Retrying... ({retries+1}/{max_retries})")
            retries += 1
            time.sleep(refresh_rate)  # Wait for 1 minute before retrying
    if retries == max_retries:
        print("Maximum number of retries reached. Exiting...")
        return None
    
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
    
    return nifty_columns


def calc_oi(nifty_range = nifty_range, expiry_date=expiry, nifty_columns=nifty_columns):
    
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
    pygame.mixer.music.load(sound_path)
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
    nifty_columns = fetch_live_data()
    oi_list_dict_array[i].append(calc_oi(nifty_range = nifty_range_array[i], nifty_columns=nifty_columns))
print('First run completed')

    
for i in range(iterations):
    time.sleep(refresh_rate)
    nifty_columns = fetch_live_data()
    
    for index in range(no_of_ranges):
        # print(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry))
        # print(f"oi_list_dict_array[index] = {oi_list_dict_array[index]}")
        oi_list_dict_array[index].append(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry,nifty_columns=nifty_columns))
        # print(f"oi_list_dict_array[index] = {oi_list_dict_array[index]}")
        supp_list_dict_array[index] = cal_oi_supp(oi_list_dict_array[index],supp_list_dict_array[index])
        
        if index == no_of_ranges//2:
            print(supp_list_dict_array[index][-1])
            
            #Check if support change is more than 10% in last 10 minutes
            try:
                # print(f'index = {index}')
                # print(f'supp_list_dict_array[index][0] = {supp_list_dict_array[index][0]}')
                # print(f'supp_list_dict_array[index][-10] = {supp_list_dict_array[index][-10]}')
                change_pe = abs(supp_list_dict_array[index][0]['pe_supp'] - supp_list_dict_array[index][-10]['pe_supp'])
                change_ce = abs(supp_list_dict_array[index][0]['ce_supp'] - supp_list_dict_array[index][-10]['ce_supp'])
                if change_pe > 10 or change_ce > 10:
                    play_sound()
            except:
                pass # donothing in case of exception for starting 10 calculations
                # print('Error in sound')
                    
        with open(str(out_files[index])+'.txt', 'w') as f:
            with redirect_stdout(f):
                for row in supp_list_dict_array[index]:
                    print(row)
    
