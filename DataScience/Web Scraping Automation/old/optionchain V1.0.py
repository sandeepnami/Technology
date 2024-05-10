import win32com.client
import time
import pandas as pd
from contextlib import redirect_stdout

expiry = "09-May-2024"
nifty_range = [22600,22700]
no_of_ranges = 3
excel_file = r"C:\Users\namis\OneDrive\Professional\Technology\DataScience\Web Scraping Automation\Options Live Data.xlsx"
refresh_rate = 1 * 60 # 2 minutes
iterations = 300
out_files = []

xl = win32com.client.DispatchEx("Excel.Application")
wb = xl.workbooks.open(excel_file)
xl.Visible = True

def calc_oi(nifty_range = nifty_range, expiry_date=expiry, oi_list_dict=[]):
    sheet2 = wb.worksheets('Sheet2')
    wb.RefreshAll()
    # time.sleep(6)
    data_table = sheet2.Range('A1').currentregion.value
    df = pd.DataFrame(data_table,columns=data_table[0])
    cols = list(df.columns)
    cols = [col.lower().strip() for col in cols]
    df.columns = cols
    df.drop(df.index[0], inplace=True)
    
    df.set_index(['expirydate'],inplace=True)
    current_expiry = df.loc[expiry_date]
    current_range = current_expiry[(current_expiry['strikeprice'] >= nifty_range[0]) & (current_expiry['strikeprice'] <= nifty_range[1])]
    ce_oi = current_range['ce.openinterest'].sum()
    pe_oi = current_range['pe.openinterest'].sum()
    oi_list_dict.append({'ce_oi':ce_oi,'pe_oi':pe_oi})    
    
    return oi_list_dict

def cal_oi_supp(oi_list_dict,supp_list_dict):
    ce_supp = (oi_list_dict[-1]['pe_oi'] - oi_list_dict[-1]['ce_oi'])*100/ oi_list_dict[-1]['ce_oi']
    pe_supp = (oi_list_dict[-1]['ce_oi'] - oi_list_dict[-1]['pe_oi'])*100/ oi_list_dict[-1]['pe_oi']
    ce_supp, pe_supp = round(ce_supp,2), round(pe_supp,2)
    supp_list_dict.append({'ce_supp':ce_supp,'pe_supp':pe_supp})
    
    return supp_list_dict
    

time.sleep(10)  # time given for opening excel file

nifty_range_array, oi_list_dict_array = [], []

#Intialisation
index = -1
for i in range(-no_of_ranges//2,no_of_ranges//2):
    index += 1
    nifty_range_array.append([nifty_range[0]+i*100,nifty_range[1]+i*100])
    oi_list_dict_array.append(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry, oi_list_dict=[])) # to get first values
    out_files.append = nifty_range[0]+i*100

supp_list_dict_array = []
for i in range(iterations):
    time.sleep(refresh_rate)
    
    index = -1
    for i in range(-no_of_ranges//2,no_of_ranges//2):
        index += 1
        nifty_range_array.append([nifty_range[0]+i*100,nifty_range[1]+i*100])
        oi_list_dict_array.append(calc_oi(nifty_range = nifty_range_array[index], expiry_date=expiry, oi_list_dict=[]))
        supp_list_dict_array[index] = cal_oi_supp(oi_list_dict_array[index],supp_list_dict_array[index])
        
        if index == 1:
            print(supp_list_dict_array[index][-1])
        
        with open(str(out_files[index])+'.txt', 'w') as f:
            with redirect_stdout(f):
                for row in supp_list_dict_array[index]:
                    print(row)
    
        