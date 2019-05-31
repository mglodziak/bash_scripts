#!/bin/bash

function confirm {
	echo "Press q to abort or any other key to continue"
read confirm

if [[ $confirm == "q" || $confirm == "Q" ]]; then
        echo "Aborting..."
        exit
fi
}

function select_naming_convention {
	full_path=$1
	ext=$2
	total_files=$3
	echo -e "\n\tFull path: $full_path"
	echo -e "t Extension: $ext"
	echo -e "\tTotal files: $total_files"

	echo -e "Please choose a naming convention:\n"
	echo -e "\t 1)Numerical followed by the extension i.e. 1.$ext 2.$ext 3.$ext"
	echo -e "\t 2)Arbitrary word followed by a number i.e. myword1.$ext myword2.$ext myword3.$ext"
	echo -e "\t q) Quit program\n"

	printf "Selection: "
	read selection
	case $selection in
		1) echo "Renaming files with sequential numbers..."
		rename_numerical $full_path $ext

			;;
		2) echo "Renaming files with custom word then numbers..."
		rename_word_numerical $full_path $ext
			;;

			
		#) dodać losowe rozwalanie nazw plików


		q|Q) echo "User quit" ;;

		*) select_naming_convention $full_path $ext $total_files ;;
	esac
}


function print_help {

 	echo "Usage:"
	echo "./renamer.sh <directory>"
}


function rename_numerical {
	full_path=$1
	ext=$2

	confirm

	echo "Renaming files..."
	files_to_rename=$(ls $full_path | grep .$ext)
	index=1

	for file in $files_to_rename
	do
		mv "${full_path}/${file}" "${full_path}/${index}.${ext}"
		let index++
	done
}


function rename_word_numerical {
	 full_path=$1
        ext=$2

printf "Select a template filename: "
read selection
echo "Your've selected $selection, the files will follow theis convention: ${full_path}/${selection}1.${ext}"

confirm
	echo "Renaming files..."
        files_to_rename=$(ls $full_path | grep .$ext)
        index=1

 for file in $files_to_rename
        do
                mv "${full_path}/${file}" "${full_path}/${selection}${index}.${ext}"
                let index++
        done


}

#______________________



if [ -d "$1" ]; then
	full_path=`readlink -f $1`
	echo "Starting batch renaming of files in folder $full_path..."

	echo "What filetype would you like to batach rename? i.e. txt jpg png zip"
	printf "Extension: "
	read ext
	echo "You've chosen the $ext extension. Looking for files with the $ext extension in $full_path dir..."
	total_files=$(ls $full_path | grep .$ext | wc -l)
	if [ $total_files -eq 0 ]; then
		echo "There are no files with that extension. Quittig" ; exit
	else
		printf "There are $total_files total files with the $ext extension in the directory\n"
		printf "Would you like to rename them? [y/n] "

		read confirm_renaming
		if [ "$confirm_renaming" == "y" ]; then
			echo "Proceeding..."
			select_naming_convention $full_path $ext $total_files


		elif [ "$confirm_renaming" == "n" ]; then
			echo "Aborting"
		else 
			echo "Non recognized"
		fi
	fi




elif [ -z "$1" ]; then
	print_help
else 
	echo "Not a directory"
	print_help
fi
