#!/bin/bash

# Script to download the Astronomy Picture Of the Day 
# from nasa.gov and set it as the desktop background in Gnome

gnome-shell --version
if [ $? != "0" ]
	then 
		echo "Gnome not installed."
		exit 1
fi

cd $HOME/Pictures
mkdir -p apod 
cd apod
rm  -fv astropix.html

echo "==========================="
wget -v https://apod.nasa.gov/apod/astropix.html

echo "==========================="
WHOLELINE=$(grep -m 1 '<a href="image' astropix.html)

if [ -z "$WHOLELINE" ]
	then
		echo "Today's APOD is not an image."
		exit 1
fi

WHOLELINE=${WHOLELINE%??}
img_name=${WHOLELINE#??????????}
wget -Nv https://apod.nasa.gov/apod/$img_name 
FILENAME="$(basename "$img_name")"

HEIGHT="$(identify -format %h "$FILENAME")"
WIDTH="$(identify -format %w "$FILENAME")"

FILESIZE="$(wc -c < "$FILENAME")"

if (( $FILESIZE < 500 
	|| $WIDTH <= 1920 || $HEIGHT <= 1080))
	then
		echo "Image too small."
		exit 1
fi

echo "==========================="
echo "file://$HOME/Pictures/apod/update$FILENAME"
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/apod/$FILENAME
gsettings set org.gnome.desktop.background picture-options zoom

rm  -fv astropix.html
echo Background set succesfully!
