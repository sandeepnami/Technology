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
nifty_range = [22300,22400]
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
    'cookie': 'defaultLang=en; _ga=GA1.1.336479484.1713945655; bm_sz=0428608D255FAF2AA2DAC87F92FB1D27~YAAQVnxBFy4ws02PAQAAabNsVhdwSL3oWF1FAn952r7XXT8QwENVX+KNQwdsnLhzGLePMRt9pwCbiDjvpP02AR40KdvCuQdwfUj7S/g2GxGIVlCbtJHE8syegyNduodnBaPWWFvXx5s6nnKWJhVPZtMXtJD+KHF+58nFhSO839J+5r1tn22hSMKe8JNizvG9SCZkhNOJFmhW3mf5/FwcAbs+BiZ4GfpT97MMDViJDQQN44v5X3AP1OI+R6RErDBlUNbebhU8WbeDxu0CHMQ60FFlsxl3bYW4blHfcW0pLeFLNUhJIaRMSJoOZIpFkfMZfjlklAvYoBoZyoaCqugeC/mGh62OzX0xrblJdaCkIue5hCEYLZw=~3747908~3552581; nsit=V8kbkGDFsNZPUpR3I4T7cBx8; AKA_A2=A; ak_bmsc=1991B5010F4AF2C9C7A47A1CBD06BBB7~000000000000000000000000000000~YAAQVnxBF1RT702PAQAAtUAqVxc8N24Pj+mkRWMsQfK9aWbYSw6U9xpqGETzBCG5Gpya1Bd0hD/Ab/qSQR/WhO5dYVaA4Pn+JTThWOMoujzpUkPArlz319oVN7yg6GmexHkz644UQizUvguJF2Ih/BPMxMyAxqloQg8vPYl4ME82uruft4nOwDddtpOpsRO1WokVdwgeDtW+8OsHfxDnsLcxrgm/z/LEwxUWRTfDAzsgeHRN+8Cn8LIEhXFZP3htBaQ3zw9vDxSSKJoKcew1kSyR4VNtZV+vHlF7W7EiUPlBc349LEMM7YTmmgO4jsld5KoWBADVi1k7c/epOu3Rbj46LiHUK3Dxic5AqY1X924nsl5GbVRzkXTCHzzPBjwnyGNCkigMAh8vKvcT3y+wLUym5OaXD84lqfad9f8sC3ry8ueRwBHeWQIIjBUxtINdRvcZrFci3Wt035ttwbe3; nseappid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGkubnNlIiwiYXVkIjoiYXBpLm5zZSIsImlhdCI6MTcxNTE1NDM0MSwiZXhwIjoxNzE1MTYxNTQxfQ.C_U91JvQybHCkAXbSvfY938hXxjGUXYMky3EsymNkng; _ga_QJZ4447QD3=GS1.1.1715154341.9.0.1715154341.0.0.0; _ga_87M7PJ3R97=GS1.1.1715154337.21.1.1715154341.0.0.0; RT="z=1&dm=nseindia.com&si=f72572b7-2bad-4417-91cd-7acb243b12df&ss=lvxiluxy&sl=0&se=8c&tt=0&bcn=%2F%2F684d0d42.akstat.io%2F"; _abck=E4B725D5404059D7A728735DAF0E7947~0~YAAQVnxBF+5b702PAQAA4VUqVwtJNuiCWDso5fY1WDlJ1i8+eP09mBmSndRIy2NlWDyHis14rrfyAhHCRwfhWUpNwTVMHE6KO1gDYXimSH2odJCuHTCDs45XlXzT/D+8+xbBTtcxzIWEq0hiUQRDbibcvlhaohyQpARSfUJFju7N08ayEF5hx91ygv/52a0Q2ur0zLV7LgjPrrXi+/0KUNt5xV5NBIwsfZM9Stcan66yA/cTnxyv0Zw3FoJMWZx/R+UC4AE3ZhR4nKO160COqm1qz0KzB+g5cmSWqHXIzM4ilQIlkBVE+5B3sItEqQb7rRjUj8BBmrYfB/rySo8MgzuIEe26zAuAN54kz7+emWP7MiyAm00P8XbX/2P00b8r~-1~-1~-1; bm_sv=80E25E723BCD9FAE2EFE97C4D38FF837~YAAQVnxBF+9b702PAQAA4VUqVxcXB2V//h32LnjtBXOUOk8puIbhEymuZcy1m3Z8/dvmAmnxj5sJ/MELqxWwyZ/ODKwQabJ+OEF8W+29pu55+tkiD6eM5uXMLb7lmuD4peByUCBfOityji6i+yjOvvYiCJQA90BXN2R9Uul80jGsez1QSaUZ0IsVbbSeZoUINDGENPhq6oNkjxe/Sjry24IfJlb59QfgT0Nwq2KaovR+WKwd3TccaCaOzIq23GPyVgo=~1'
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
    
