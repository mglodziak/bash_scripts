#!/bin/bash


function print_help {

        
        printf "\nProgram back1thing Tworzy archiwum o nazwie wyjściowego pliku z zadanym rozszerzeniem "

        echo "Jak używać:"
        echo -e "./back2thing <katalog/plik> <rozszerzenie> [ścieżka] \n"
	}


if [[ -f "$1" || -d "$1" ]]; then
	
	if [ -z "$2" ]; then
        echo "Błędnie uruchamiasz program."
        print_help
	exit
	fi

	if [ -z "$3" ]; then
		zm='./'
	elif [ ! -z "$3" ]; then
		zm=$3
	fi



	case $2 in 
	       	tar) tar cvf $zm/$1.$2 $1      		;;
		tgz) tar -cvzf $zm/$1.$2 $1     	;;
		tar.gz) tar -czvf $zm/$1.$2 $1  	;;
		tar.bz2) tar -cvjSf $zm/$1.$2 $1        ;;
                tbz2) tar -cvjSf $zm/$1.$2 $1           ;;
                bz2) tar -cvjSf $zm/$1.$2 $1            ;;
		rar) rar a $zm/$1.$2 $1                 ;;
                gz) gzip $1         			;;
                zip) zip -c $zm/$1.$2 $1                ;;
                7z) 7z a $zm/$1.$2 $1                   ;;
                xz) tar cfJ $zm/$1.$2 $1  		;;
                *) echo "'$2' jest nieznanym rozszerzeniem. Wyjście"
			print_help
        esac

elif [ -z "$1" ]; then
        echo "Błędnie uruchamiasz program."
        print_help
else
        echo "Katalog/plik '$1' nie istnieje"
fi
	


#copyright Mikołaj Głodziak, 06.03.2019
