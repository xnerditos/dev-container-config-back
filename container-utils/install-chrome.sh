#!/bin/bash

sudo apt update 
sudo apt install libxss1 libappindicator1 libindicator7 -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb -y
rm ./google-chrome*.deb

