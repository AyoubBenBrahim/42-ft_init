#!/bin/bash

awk 'BEGIN{print "| LOGIN ; | UID ; | PATH ; |"}' > temp1
cat /etc/passwd | awk -F':' ' {print "|",$1,";","|",$3,";","|",$6,";","|"}' >> temp1 
cat temp1 | column -t -s';' > temp
rm temp1

longest_lenght=$(cat temp | awk ' { if ( length > x ) { x = length } }END{ print x }')

for ((i=0; i<$longest_lenght; i++))
do
	if (( $i == 0 || $i == $longest_lenght - 1)); then
		tab0[$i]="+"
	else
		tab0[$i]="-"
	fi
done

printf "\n"

j=0
while (( j<longest_lenght ))
do
	if (( $j == 0 || $j == longest_lenght - 1 || $i == $login_width )); then
		tab1[$j]="+"
	else
		tab1[$j]="-"
	fi
	j=$(( j+1 ))
done

printf "%s" "${tab1[@]}" && printf "\n"

while read line
do
	header=$(echo "$line" | awk '/LOGIN/ {print}')
	real_user=$(echo $line | awk -F'|' '($3 >= 100 && $3 < 210) {print $0}')
	if [ "$header" ]; then
		echo "$line" | awk '{ print "\033[41m" "\033[1m" $0 "\033[0m"}'
	elif [ "$real_user" ]; then
		echo "$line" | awk '{ print "\033[42m" $0 "\033[0m"}'
	else
		echo "$line" | awk '{ print "\033[100m" $0 "\033[0m"}'
	fi
	printf "%s" "${tab1[@]}" && printf "\n" 
done < temp
rm temp
