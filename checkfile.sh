#!/bin/bash

COMMAND=$(cat text.txt)
COMMAND2=$(eval echo \"$COMMAND\")
echo $COMMAND
echo $COMMAND2
