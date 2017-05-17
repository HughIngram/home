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

path_to_images="$HOME/Pictures/apod"
mkdir -p "$path_to_images" 
rm  -fv "$path_to_images/astropix.html"

echo "==========================="
wget -v https://apod.nasa.gov/apod/astropix.html -P "$path_to_images"

echo "==========================="
wholeline="$(grep -m 1 '<a href="image' "$path_to_images/astropix.html")"

if [ -z "$wholeline" ]
	then
		echo "Today's APOD is not an image."
		exit 1
fi

wholeline=${wholeline%??}
img_address=${wholeline#??????????}

wget -Nv "https://apod.nasa.gov/apod/$img_address" -P "$path_to_images"
path_to_image_file="$path_to_images/""$(basename "$path_to_images/$img_address")"

height="$(identify -format %h "$path_to_image_file")"
width="$(identify -format %w "$path_to_image_file")"
filesize="$(wc -c < "$path_to_image_file")"

if (( filesize < MIN_IMG_SIZE
	|| width <= MIN_IMG_WIDTH || height <= MIN_IMG_HEIGHT ))
	then
		echo "Image too small."
		exit 1
fi

echo "==========================="
echo "file://$HOME/Pictures/apod/$path_to_image_file"
gsettings set org.gnome.desktop.background picture-uri file://"$path_to_image_file"
gsettings set org.gnome.desktop.background picture-options zoom

rm  -fv "$path_to_images/astropix.html"
echo Background set succesfully!

#TODO use feh as a fallback if Gnome is not available
