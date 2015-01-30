#!/bin/bash
#Script to select and apply a desktop background
#The image used is chosen at random from $backgrouds_directory

backgrounds_directory="Dropbox/Backgrounds"
mkdir -p "$HOME/$backgrounds_directory"
cd "$HOME/$backgrounds_directory"

number_of_files=`ls -1 | wc -l`

#select a line number at random
random_line=`shuf -i 0-"$number_of_files" -n 1`

#get the filename at $random_line
file_name=`ls -1 | sed -n "$random_line"p`

#check if the file is an image
if [[ $file_name =~ \.jpg$ ]]; then 
	echo "file://$HOME/$backgrounds_directory/$file_name"
	gsettings set org.gnome.desktop.background picture-uri file://$HOME/$backgrounds_directory/$file_name
	gsettings set org.gnome.desktop.background picture-options zoom
else
	echo "$file_name is not a useable image"
fi
