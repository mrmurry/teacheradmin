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
    #echo $COMMAND
    scp /etc/profile $i:~/newprofile
    scp /etc/environment $i:~/newenv
    scp ~/.bashrc $i:~/newbashrc
    ssh -t $i "$COMMAND"
    echo "Finished $i"
done
