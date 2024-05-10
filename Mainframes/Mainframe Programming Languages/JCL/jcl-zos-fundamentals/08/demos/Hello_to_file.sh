#!/bin/sh 
while IFS= read -r line 
do
	echo "Hello, ${line}!"
done < $1 
exit 0	