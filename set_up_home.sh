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


#install various programs

apt install htop filezilla terminator vim gcc make ghc xsel

#install install this repo

cd $HOME
home_repo="home"
cd $HOME
if [  -e "$home_repo" ]; then
    cd "$HOME""/""$home_repo";
    cp -v .bash_profile ..;
    cp -v .bashrc ..;
    cp -v .vimrc ..;
    cp -v .ideavimrc ..;
    cp -v .xmodmap-esc ..;
    
    #the below is only executed if the computer is a ThinkPad laptop
    if [[ -n "$(sudo dmidecode | grep ThinkPad)" ]]; then
        log+="lubuntu-rc.xml copied\n";
        cp -v lubuntu-rc.xml $HOME/.config/openbox/lubuntu-rc.xml;
    else
        log+="lubuntu-rc.xml not copied\n";
    fi
fi
	
exit
