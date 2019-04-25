#!/bin/bash

#Initialize correct computer list file
if [ -z $2 ];
then
    readarray -t lines < "computerlist.txt"
else
    readarray -t lines < $2
fi

#Declare associative arrays for computer names and program pid's
declare -A names
declare -A waitpids

while IFS==" " read -r compname username
do
    names[$compname]=$username
done < computerlist.txt

read -e -p "Enter command to execute: " WORD1 WORD2 WORD3 WORD4 WORDN
FILECOMMAND="$WORD1 $WORD2 $WORD3 $WORD4 $WORDN"

CMDTIME=$(date | awk '{print $4}')
NOPATH=${1#remotecommands/*}
ERRORFILE="$HOME/teacheradmin/failedlists/${NOPATH%.*}.err-$CMDTIME"
echo $ERRORFILE

for i in "${!names[@]}"
do
    COMMAND=$(eval echo \"$FILECOMMAND\")
    echo "$COMMAND"

    #nohup ssh -t $i "$COMMAND" >& /dev/null &
    ssh -t $i "$COMMAND"
    waitpids[$i]=$!
done

for i in "${!names[@]}"
do
    wait ${waitpids[$i]}
    if [ $? -ne 0 ];
    then
        echo "$i ${names[$i]}" | cat >> $ERRORFILE
    fi
done
