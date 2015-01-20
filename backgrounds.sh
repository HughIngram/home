#!/bin/bash

#script to download the APOD from NASA and set it as the desktop background

cd $HOME/Pictures
mkdir -p apod 
cd apod
#pwd
rm  -fv --one-file-system astropix.html
echo

echo downloading web page http://apod.nasa.gov/apod/astropix.html
echo ===========================
wget -v http://apod.nasa.gov/apod/astropix.html
echo ===========================

wholeline=$(grep -m 1 '<a href="image' astropix.html)

#echo wholeline = $wholeline
wholeline=${wholeline%??}
#echo wholeline = $wholeline
wholeline=${wholeline#?????????}
#echo wholeline= $wholeline
echo
echo Downloading image at http://apod.nasa.gov/apod/$wholeline
echo
wget -Nv "http://apod.nasa.gov/apod"/$wholeline 
echo ===========================
filename=$(basename $wholeline)
echo downloaded image:
ls -lh | grep $filename
echo
echo Script Complete!
echo ===========================
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/apod/$filename
gsettings set org.gnome.desktop.background picture-options zoom

