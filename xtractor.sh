#!/bin/bash

if [ -f "$1" ]; then
	echo "Initializing"


	case $1 in
		*.tar) tar xvf $1 	;;
		*.tgz) tar xzf $1 	;;
		*.txz) tar -xf $1 	;;
		*.tar.gz) tar xzf $1 	;;
		*.tar.bz2) tar xjf $1 	;;
		*.tbz2) tar xjf $1 	;;
		*.bz2) bunzip2 $1 	;;
		*.rar) rar x $1 	;;
		*.gz) gunzip $1 	;;
		*.zip) unzip $1 	;;
		*.Z) uncompress $1 	;;
		*.7z) 7za x $1 		;;
		*.xz) xz -d $1		;;
		*) echo "'$1' is not a recognized archive. Quitting" ; exit
	esac


elif [ -z "$1" ]; then
	echo "No file provided. Usage:"
	echo " ./xtractor.sh <file>"
else
	echo "File '$1' doesn't exist"
fi
