import os
import sys

def make_at(path, dir_name):
    original_path = os.getcwd()
    os.chdir(path)
    try:
        os.mkdir(dir_name)
    finally:
        os.chdir(original_path)

