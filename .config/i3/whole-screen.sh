#!/bin/bash
if [ "$1" == "" ]
then
    echo "No input file given"
    exit 1
fi
set -o errexit
set -o pipefail
set -o nounset

import -silent -window root "$1"
notify-send --expire-time 2000 "Screen captured to "$1""
xclip -selection clipboard -target "$(xdg-mime query filetype "$1")" "$1"
