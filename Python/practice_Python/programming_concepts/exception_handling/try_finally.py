import os
import sys

def make_at1(path, dir_name):
    original_path = os.getcwd()  #returns current working directory
    os.chdir(path)
    os.mkdir(dir_name)
    os.chdir(original_path) # we need to get back to original source direcgtory.

def make_at2(path, dir_name):
    original_path = os.getcwd()
    os.chdir(path)
    try:
        os.mkdir(dir_name)
    finally:
        os.chdir(original_path)
    
def make_at3(path, dir_name):
    original_path = os.getcwd()
    os.chdir(path)
    try:
        os.mkdir(dir_name)
    except OSError as e:
        print(e, file=sys.stderr)
        raise
    finally:
        os.chdir(original_path)
        
def main():
    #make_at1("D:\Sandeep\Technology\DataScience\Python\python_practice","nami_dir1")
    #make_at2("D:\Sandeep\Technology\DataScience\Python\wrong","nami_dir2")
    make_at3("D:\Sandeep\Technology\DataScience\Python\wrong","nami_dir3")
    
if __name__=="__main__":
    main()
