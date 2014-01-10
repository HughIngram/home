#!/bin/bash

#script to download the APOD from NASA and set it as the desktop background

cd /home/hugh/Pictures
mkdir -p apod 
cd apod
#pwd
rm  -fv --one-file-system *.html *.jpg *.jpeg *.png
echo

echo downloading web page http://apod.nasa.gov/apod/astropix.html
echo
wget -v --no-use-server-timestamps http://apod.nasa.gov/apod/astropix.html

yearmonth=$(date --date="yesterday" +"%y%m")
wholeline=$(grep -m 1 $yearmonth astropix.html)

echo
#echo wholeline = $wholeline
wholeline=${wholeline%??}
#echo wholeline = $wholeline
wholeline=${wholeline#?????????}
#echo wholeline= $wholeline
#echo
echo Downloading image at http://apod.nasa.gov/apod/$wholeline
echo
wget -N "http://apod.nasa.gov/apod"/$wholeline 
echo
echo ============= mv -vf =============
mv -vf *.jpg background.jpg
mv -vf *.png background.png
echo ==================================

gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/apod/background.png
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/apod/background.jpg
gsettings set org.gnome.desktop.background picture-options zoom
echo
echo background changed succesfully
