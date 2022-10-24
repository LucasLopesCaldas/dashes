#!/bin/bash

echo "If necessary, do you want to install the following dependencies?"  
echo 
echo "python3.8-venv"
echo "scrot"
echo "tesseract"
echo 
read -p "y(yes) | n(no): " dep

if [ $dep == "y" ]; then
    sudo apt update
    sudo apt install python3.8-venv -y
    sudo apt-get install scrot -y
    sudo apt install tesseract-ocr -y
    sudo apt install libtesseract-dev -y
elif [ $dep == "n" ]; then
    exit
fi

echo $'===> Creating venv...'
python3 -m venv /home/lucaslopes/Projects/image2text/.venv
source /home/lucaslopes/Projects/image2text/.venv/bin/activate
echo $'===> Venv created!'
echo $'===> Installing packages\n'
pip install wheel
pip install -r /home/lucaslopes/Projects/image2text/requirements.txt