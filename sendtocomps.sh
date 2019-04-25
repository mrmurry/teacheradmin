#!/bin/bash

readarray -t lines < "computerlist.txt"

declare -A names

while IFS==" " read -r compname username
do
    names[$compname]=$username
done < computerlist.txt

for i in "${!names[@]}"
do
    scp "$1" $i:"$2"
    echo "Finished $i"
done
