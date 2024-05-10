import os

folder_original = '/Users/sarah/Desktop/'
folder_destination = '/Users/sarah/Desktop/CleanedUp/'

os.mkdir(folder_destination)

for entry in os.scandir(folder_original):
    location_original = os.path.join(folder_original, entry.name)
    location_destination = os.path.join(folder_destination, entry.name)
    
    if os.path.isfile(location_original):
        os.rename(location_original, location_destination)