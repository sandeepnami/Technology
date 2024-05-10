import cv2
import numpy as np
import pytesseract

# Defining paths to tesseract.exe
# and the image we would be using
pytesseract.pytesseract.tesseract_cmd = r"C:\Users\namis\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.9_qbz5n2kfra8p0\LocalCache\local-packages\Python39\Scripts\pytesseract"
image_path = r"C:\Users\namis\OneDrive\Professional\Technology\Practice\00_Practice_Python\tempimg2.png"

# Opening the image & storing it in an image object
img = cv2.imread(image_path)

#Alternatively: can be skipped if you have a Blackwhite image
gray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
gray, img_bin = cv2.threshold(gray,128,255,cv2.THRESH_BINARY | cv2.THRESH_OTSU)
gray = cv2.bitwise_not(img_bin)

kernel = np.ones((2, 1), np.uint8)
img = cv2.erode(gray, kernel, iterations=1)
img = cv2.dilate(img, kernel, iterations=1)
out_below = pytesseract.image_to_string(img)
print("OUTPUT:", out_below)
