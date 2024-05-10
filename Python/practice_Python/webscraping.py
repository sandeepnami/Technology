import requests
start_url='https://www.iseecars.com:443/used-cars/used-tesla-for-sale'

downloade_page=requests.get(start_url)
print(downloade_page.text)