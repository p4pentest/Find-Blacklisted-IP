#!/bin/bash

# Author = "Abhijit Maity & Dhirendra Deora"
# Last Update Date = "15-Jul-2015"


echo "Enter File Name :"
read file
echo
echo "Please wait.."
echo

c=`wc -l $file | cut -d " " -f1`
count=0
f=0
t=1

for (( i=1 ; i <= $c ; i++ ))
do
	ip=`sed -n ''$i'p' $file`
	url="http://www.ipvoid.com/scan/"$ip
	resp=`curl -silent $url| grep "BLACKLISTED" | wc -l`

	if [ "$resp" != 0 ]
	then
		f=1
		echo
		count=`expr "$count" + "$t"`
                echo
                echo $count "IP found !!!"
		echo
		echo $ip >> blacklist_output_$file_.txt 
	fi
	stat=`expr "$c" - "$i"`
	echo $stat "IPs are left..."
done

if [ "$f" == 0  ]
then
	echo "Sorry !! No IPs were found !!!"
else
	echo	
	echo "Thats it !!! We are done..."
	echo $count "IPs were found !!! Please check the output file 'blacklist_output_$file.txt'..."
	echo
fi
