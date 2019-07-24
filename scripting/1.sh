#!/bin/bash

echo " LOGIN ; UID ; PATH ;" > temp1
echo " ********************* ; *** ; ******************** ;" >> temp1
cat /etc/passwd | awk -F':' ' {print $1,";",$3,";",$6,";"}' >> temp1 
cat temp1 | column -t -s';' > temp
rm temp1

while read line
do
	echo "$line"
done < temp
rm temp
