"""
    V2.0 : Python is used to fetch live options data instead of Excel Power Query
    V2.1 : added time to the output file
    V2.2 : added retry for 5min to fetch option chain
"""
import pandas as pd
import requests
import time
from contextlib import redirect_stdout
import pygame
from datetime import datetime

max_retries = 15
request_timeout = 15 # seconds
iterations = 300
refresh_min = 1 # minutes
refresh_rate = refresh_min*60 # seconds
expiry = "09-May-2024"
nifty_range = [22500,22600]
no_of_ranges = 5
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
    'cookie': 'defaultLang=en; _ga=GA1.1.336479484.1713945655; _abck=E4B725D5404059D7A728735DAF0E7947~0~YAAQVnxBFzuzwEyPAQAA0n4SUQtbOtpSRohPWNs+AfisV/4A3bIFU6vrDuU1YJuuLJFWtnqRRFy4lfPqgpASsUSb1kFKA8MVI/1dNGUHbF/vAnZTabuwkL75OTLvnn5ML2BWFKR8ti+wMaz094VyPW7dHorSqUYouy69cOuqUyvRTSPjdpNrXhvd71AWhUZ3HQnZ1M1kg/NgTVRJILdfcNUnAurPVzL+My1IAhbTdjkvLdo+sNddvv73oZdeF+ejiOmPYKgAP6obWhQxs7vfZRSWW4nUUTItrWO4c8YTjaeiT+D+t4HEsCwNH6UkHLq0iYN2cshuJstjeTEG5JKS24Aqn9lw0or1Ctt+FbEUnjukGswVQ+3ryJtUdFtTgDRcrR9OAM9AiickFwcwBZ8Upozd+tV9XlxnO50=~-1~-1~-1; nsit=1uqKrsd5a9g4fOOe4giUtmnC; AKA_A2=A; bm_mi=A19313971E253859DF18770BB483B862~YAAQVnxBF9iw40yPAQAADmGXURd6M6gylevNKlDkDif1k6B7Fmn6UKeTiVGXabDjbZKkliiB4KlZGSChnKCPn/mwfh7LhfS5rjVbBm0kCG9HVRn+IDso4CyXBSLVji+ZOh8ssAj0dbdCPRDrRN8IL6q/LnmdQvb9VX+fSzz0OH6wsmoOC75sZ7a90zAOU8jKol2QRTOuHqhMOynYPcUg3TKl3rWmRiHPC0tPmSvv/K1lny6S65ZQ37rB7WMdNJFEFVXdjTQghCm47l5CE+0XZ3jsiIWCA/3KAtJWSjJwP1N21ed64R04udriaiP9SlWk6D9pfdAF3FzpVzxT~1; ak_bmsc=0D13FB563F962F8A65D1AB7936932E29~000000000000000000000000000000~YAAQVnxBF92x40yPAQAAdGWXURdiAXBSl2nTSX3ZROxEpfOUdwvrqpdF6QfV7ei9D4bTNBFWUluhZO4dz8ajOsB7oRBseQ6UogUvxQnsztrG52rzfLDtJghZLZm/Ykn5iPElIUP8fVtR5krbO+9RqkUHmnEja0Oj9b+dl9mQSXuQdGB7YgJ25UzGOaiic+vzpbcWxIJaxUGOgvdMb8ILwXN2uDND6TZpSMoGlLonb2Un+U0fAZHbRD//0AmkOvzpWbSIz1pn+sJnYTPvvFOc26HvxW5d8uuxuoR8gj4Ic5Fj0s5Ou7QIo7xC1U+/6ULJ9OKy9HLYxRWRJBdNUq0M/HhWBlJmrYWzyXrne1pLywiNgyhQN0qerG+jbIUzuu7hXwSdXKxWyUQt9Yul17DytwtjOKW5QAh2N5wFdmsfUw0HasnYw9xjO7U5PGz6knF6GbkPG11qBC/iVvIxKXRxD/Kl3ToPR2xjGYIHmin8t87gREsmMvJt/EB6QG5+; _ga_QJZ4447QD3=GS1.1.1715062999.7.0.1715063183.0.0.0; nseappid=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcGkubnNlIiwiYXVkIjoiYXBpLm5zZSIsImlhdCI6MTcxNTA2MzE4NiwiZXhwIjoxNzE1MDcwMzg2fQ.jny5K3wfhxIa-uXJP0D4pn3A703SXUwj2AKxOn60mSE; bm_sz=8E5153A594A1235C81429263AB142033~YAAQVnxBF51j70yPAQAA/mO7UReidAUxNQ/yQFnyhQf2VQsA5LDM9jNkqqVaU+wIVtnmGmnUA7vsq0PUc+aejy3PdFa9j9SKWAcWjkowPyiiOAIuzdVCsw8fP0omRTMIlYarOA288ZqXdkD+bQx4wUNsNi0ltBVnyVUc4CkVAAf5JOle8jFLw4VD6j4lz9YuaxPrZ0nXac0VH5PTw3ywV2loxgdavpSYI4PrG/+jctu/oofwHXMOWNBweuejj1TaFxd8fEy04UDp5R4gOJGi7q1HCTpYJNXGjK0cXWLR63lspHRwb0t2FhCzGKH5HOnhI8vBEAq3e8qhSwODBwstJUANLPJADfBas3k981vz4FRbe98FHMoWh6bvsjw7zunZOCxh/2/LD8qPs9xbghtIa60yqsO+qKeKM9vPeojDKmTBaOEi+NaElQA4yI/hI+qrxRHffqSlEvT3k6JQ+LqQkBUowasOj6pPKKQCdhOgEQGyevT7ihi7JV5bvNCR1czcycJ837Rk95IWdvngeaDS81lZdb9xQnOnIR8qUgDAzA==~3687478~4534854; RT="z=1&dm=nseindia.com&si=f72572b7-2bad-4417-91cd-7acb243b12df&ss=lvw08699&sl=1&se=8c&tt=rv&bcn=%2F%2F684d0d43.akstat.io%2F"; _ga_87M7PJ3R97=GS1.1.1715062997.18.1.1715063187.0.0.0; bm_sv=CEB30E60156AD91A0552DA0A06310BE6~YAAQVnxBFwNl70yPAQAA/me7URcvBCKTmOocNsr7mDN4oUgLAUGA1wPcuurEpZkDHSVvvDIm15WDCxSR3r9Ik4gcxjkA22FYrB2fG7Du+pWNd4uxT9P0a2ykdnShcLzkTr4HpKQV/6vXBpr5Z0VaXhU1Q0QLGsf4zopWZBxVTrU6zIdz23HpchjsixhixAnb0zLw5SUEJMXLnpnzKX5HPFFhfjq3GIQMMRhnoOOqX6Hh++eXTbxCumz3MsUft9gKxDWOlA==~1'
}



## Functions
def fetch_live_data():
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
            if len(supp_list_dict_array[index]) > 10:
                change_pe = abs(supp_list_dict_array[index][0]['pe_supp'] - supp_list_dict_array[index][-10]['pe_supp'])
                change_ce = abs(supp_list_dict_array[index][0]['ce_supp'] - supp_list_dict_array[index][-10]['ce_supp'])
                if change_pe > 10 or change_ce > 10:
                    play_sound()
                    
        with open(str(out_files[index])+'.txt', 'w') as f:
            with redirect_stdout(f):
                for row in supp_list_dict_array[index]:
                    print(row)
    
