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

FILECOMMAND=$(cat $1)

CMDTIME=$(date | awk '{print $4}')
NOPATH=${1#remotecommands/*}
ERRORFILE="$HOME/teacheradmin/failedlists/${NOPATH%.*}.err-$CMDTIME"
echo $ERRORFILE

for i in "${!names[@]}"
do
    COMMAND=$(eval echo \"$FILECOMMAND\")

    #nohup ssh -t $i "$COMMAND" >& /dev/null &
    nohup ssh -t $i "$COMMAND" >& /dev/null &
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
