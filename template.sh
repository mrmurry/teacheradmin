#!/bin/bash

readarray -t lines < "computerlist.txt"

declare -A names

while IFS==" " read -r compname username
do
    names[$compname]=$username
done < computerlist.txt

for i in "${!names[@]}"
do
    FILECOMMAND=$(cat $1)
    COMMAND=$(eval echo \"$FILECOMMAND\")
    nohup ssh -t $i "$COMMAND" >& /dev/null &
    echo "Finished $i"
done
