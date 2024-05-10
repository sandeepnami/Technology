## File Handling
import os, sys    #import multiple packages
print('Path of current directory',os.getcwd()) 
print('arguments passed from terminal',sys.argv) #like python file_hadling.py 1 2 3 4 
print('absolute path of file',sys.argv[0]) 
__location__ = os.path.realpath(os.getcwd())
print('real path=',__location__)

# read csv file
import pandas as pd
#f=os.path.join(__location__,"price_new.csv") # full path
f="price_new.csv" # relative path
file_data=pd.read_csv(f)
print(file_data.head())

