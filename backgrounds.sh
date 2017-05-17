#!/bin/bash

# Script to download the Astronomy Picture Of the Day 
# from nasa.gov and set it as the desktop background in Gnome.
#	Dependencies: Gnome, imagemagick


# The minimum acceptable file size for background images, in kB
MIN_IMG_SIZE=500

# The mininum acceptable height for background images, in pixels
MIN_IMG_HEIGHT=1080

# The mininum acceptable width for background images, in pixels
MIN_IMG_WIDTH=1920

if ! gnome-shell --version
	then 
		echo "Gnome not installed."
		exit 1
fi

cd "$HOME/Pictures"
mkdir -p apod 
cd apod
rm  -fv astropix.html

echo "==========================="
wget -v https://apod.nasa.gov/apod/astropix.html

echo "==========================="
wholeline="$(grep -m 1 '<a href="image' astropix.html)"

if [ -z "$wholeline" ]
	then
		echo "Today's APOD is not an image."
		exit 1
fi

wholeline=${wholeline%??}
img_address=${wholeline#??????????}

wget -Nv https://apod.nasa.gov/apod/$img_address 
filename="$(basename "$img_address")"

height="$(identify -format %h "$filename")"
width="$(identify -format %w "$filename")"
filesize="$(wc -c < "$filename")"

if (( filesize < MIN_IMG_SIZE
	|| width <= MIN_IMG_WIDTH || height <= MIN_HEIGHT ))
	then
		echo "Image too small."
		exit 1
fi

echo "==========================="
echo "file://$HOME/Pictures/apod/update$filename"
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/apod/$filename
gsettings set org.gnome.desktop.background picture-options zoom

rm  -fv astropix.html
echo Background set succesfully!

#TODO use feh as a fallback if Gnome is not available
