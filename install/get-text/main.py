import os
from time import sleep
import pyautogui
from gui import select_region
import img2text

image_path = '/home/lucaslopes/Projects/image2text/screenshot.png'
xsel_path = '/home/lucaslopes/Projects/image2text/xsel'

screenshot = pyautogui.screenshot(image_path)
region = select_region(image_path)
try:
    os.remove(image_path)
except:
    ...

screenshot = pyautogui.screenshot(image_path, region=region)


os.system("echo '{}' | {} --clipboard".format(img2text.extract_text(image_path, 'por'), xsel_path))

try:
    os.remove(image_path)
except:
    ...
