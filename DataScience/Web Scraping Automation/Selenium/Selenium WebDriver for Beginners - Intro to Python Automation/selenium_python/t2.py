from selenium import webdriver
from selenium.webdriver.common.by import By as By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()

# Write your code here
driver.get('https://twitch.tv')

logo_id = driver.find_element(By.ID, 'root')
print(f'logo_id.tag_name = {logo_id.tag_name}')

logo_class = driver.find_element(By.CLASS_NAME, 'tw-link')
print(f'logo_class.tag_name = {logo_class.tag_name}')

logo_tag = driver.find_element(By.TAG_NAME, 'a')
print(f'logo_tag.accessible_name = {logo_tag.accessible_name}')

logo_css = driver.find_element(By.CSS_SELECTOR, 'a.tw-link')
print(f'logo_css.accessible_name = {logo_css.accessible_name}')

logo_xpath = driver.find_element(By.XPATH, '//*[@id="root"]/div/div[1]/nav/div/div[1]/a')
print(f'logo_xpath.accessible_name = {logo_xpath.accessible_name}')

driver.quit()
