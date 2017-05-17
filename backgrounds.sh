#!/bin/bash

# Script to download the Astronomy Picture Of the Day 
# from nasa.gov and set it as the desktop background in Gnome.
#	Dependencies: Gnome, imagemagick


# The minimum acceptable file size for background images, in kB
MIN_SIZE=500

# The mininum acceptable height for background images, in pixels
MIN_HEIGHT=1080

# The mininum acceptable width for background images, in pixels
MIN_WIDTH=1920

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
WHOLELINE="$(grep -m 1 '<a href="image' astropix.html)"

if [ -z "$WHOLELINE" ]
	then
		echo "Today's APOD is not an image."
		exit 1
fi

WHOLELINE=${WHOLELINE%??}
IMG_ADDRESS=${WHOLELINE#??????????}

wget -Nv https://apod.nasa.gov/apod/$IMG_ADDRESS 
FILENAME="$(basename "$IMG_ADDRESS")"

HEIGHT="$(identify -format %h "$FILENAME")"
WIDTH="$(identify -format %w "$FILENAME")"
FILESIZE="$(wc -c < "$FILENAME")"

if (( $FILESIZE < $MIN_WIDTH 
	|| $WIDTH <= $MIN_WIDTH || $HEIGHT <= $MIN_HEIGHT ))
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

#TODO use feh as a fallback if Gnome is not available
