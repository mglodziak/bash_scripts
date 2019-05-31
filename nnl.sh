#!/bin/bash

#Skrypt wyswietla numer co n-tej linii w pliku, gdzie n to parametr

function print_help {

        echo "Info"
        printf "Numbering lines in file with demanded frequency\n\n"

        echo "Usage:"
        echo "nnl <file> <integer>"
}

if [[ -z $1 || -z $2 ]]; then
	echo "Requested 2 arguments. Exiting..."
	print_help
	exit

elif [[ ! -f $1 ]]; then
	echo "Argument '$1' is not a file. Exiting..."
	print_help
	exit

elif [[ $2 -lt 1 ]]; then
	echo "Your argument '$2' must be greather than zero. Exiting..."
	print_help
	exit
fi




cat -n $1 | tail -1 | tr '[:blank:]' '\n' | tr -s '\n' | head -2 | tail -1 > tmp

liczba=$(cat tmp | tr '[:blank:]' '\n')
rm tmp

cat -n $1 > d1



for (( i=1; $i <= $liczba; i++ )) ; do

	if [ $(($i % $2)) -gt 0  ]; then

	cat d1 | sed -n "$i,$i"p | tr '\t' '\n' | tail -1 |sed -e 's/^/\t/g'

	elif [ $(($i % $2)) -eq 0 ]; then
cat d1 | sed -n "$i,$i"p
	fi
done

rm d1

