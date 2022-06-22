#!/bin/bash
if [ "$1" == "" ]
then
    echo "No input file given"
    exit 1
fi
set -o errexit
set -o pipefail
set -o nounset

import -silent "$1"
xclip -selection clipboard -target "$(xdg-mime query filetype "$1")" "$1"
