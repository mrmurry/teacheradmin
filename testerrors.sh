#!/bin/bash

readarray -t lines < "computerlist.txt"

declare -A names

while IFS==" " read -r compname username
do
    names[$compname]=$username
done < computerlist.txt

FILECOMMAND=$(cat $1)
COMMAND=$(eval echo \"$FILECOMMAND\")
ERRORFILE="$HOME/errors.txt"

nohup ssh -t computer1 "$COMMAND &" >& /dev/null 
echo $?
