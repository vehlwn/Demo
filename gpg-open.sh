#!/bin/bash

if [ "$1" == "" ]
then
    echo "No input file given"
    exit 1
fi
in_file="$1"
out_file="$(mktemp)"
gpg --yes -d -o $out_file $in_file
if [ "$?" != "0" ]
then
    echo "Failed to decrypt file"
else
    echo "Opening flle..."
    nvim $out_file
    gpg --yes -e -s -o $in_file $out_file
fi
rm $out_file
