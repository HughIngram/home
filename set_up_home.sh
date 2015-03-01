#!/bin/bash

#bash script to configure my personal 'set-up' in Ubuntu
#steps are: 	-install packages
#		-download various dotfiles and scripts from github
#		-copy config files to correct location

#TODO run git configuration

log="======= LOG =======\n"

if [ "$(whoami)" != root ]; then
	echo -e "\nPlease run this script as root!\n" >&2
	exit 1
fi

ping -c1 8.8.8.8
if [ ! $? -eq 0 ]; then 
	echo -e "\nNo internet access!\n" >&2
	exit 2
fi

cd $HOME

#install various programs

apt-get install htop
if [ $? -eq 0 ]; then
	log+="htop installed succesfully\n";
else
	log+="error while installing htop\n";
fi

apt-get install filezilla 
if [ $? -eq 0 ]; then
	log+="filezilla installed succesfully\n";
else
	log+="error while installing filezilla\n";
fi

apt-get install terminator
if [ $? -eq 0 ]; then
	log+="terminator installed succesfully...\n";
else
	log+="error while installing terminator\n";
fi

apt-get install vim
if [ $? -eq 0 ]; then
	log+="vim installed succesfully...\n";
else
	log+="error while installing vim\n";
fi

apt-get install gcc
if [ $? -eq 0 ]; then
	log+="gcc installed succesfully...\n";
else
	log+="error while installing gcc\n";
fi

apt-get install make
if [ $? -eq 0 ]; then
	log+="make installed succesfully...\n";
else
	log+="error while installing make\n";
fi

apt-get install ghc
if [ $? -eq 0 ]; then
	log+="ghc installed succesfully...\n";
else
	log+="error while installing ghc\n";
fi

#install git then download and install 'home' repo
apt-get install git
if [ $? -eq 0 ]; then
	log+="git installed succesfully...\n";
	
	home_repo="home"
	if [ ! -e "$home_repo" ]; then
		log+="home repo not found locally. Cloning home repo...\n"; 
		git clone https://github.com/HughIngram/home.git;
	else
		log+="home repo already exists. Using existing version\n";
	fi
	
	cd $HOME
	if [  -e "$home_repo" ]; then
		cd "$HOME""/""$home_repo";
		cp -v .bash_profile ..;
		cp -v .bashrc ..;
		cp -v .vimrc ..;
		cp -v .xmodmap-esc ..;
		cp -v backgrounds.sh ..;
		cp -v random_background_selector.sh ..;
		if [ $? -eq 0 ]; then
			log+="files in home repo copied succesfuly\n";
		else
			log+="files in home repo not copied\n";
		fi
		
		#the below is only executed if the computer is a ThinkPad laptop
		if [[ -n "$(sudo dmidecode | grep ThinkPad)" ]]; then
			log+="lubuntu-rc.xml copied\n";
			cp -v lubuntu-rc.xml $HOME/.config/openbox/lubuntu-rc.xml;
		else
			log+="lubuntu-rc.xml not copied\n";
		fi
	fi
	
else 
	log+="git not installed succesfully\n";
	exit 1;
fi
echo -e "$log"
exit
