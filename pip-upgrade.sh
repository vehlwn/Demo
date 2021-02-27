#!/bin/bash

tmpfile=$(mktemp)
pip3 freeze > "$tmpfile"
sed 's/=.*$//' -i "$tmpfile"
pip3 install -r "$tmpfile" --upgrade
rm "$tmpfile"
