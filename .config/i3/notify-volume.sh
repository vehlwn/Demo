#!/bin/bash

function get_icon_by_name(){
    echo "/usr/share/icons/Adwaita/16x16/status/audio-volume-${1}-symbolic.symbolic.png"
}
function get_icon_by_level() {
    local icon_name
    if [ ${1} -gt 100 ]
    then
        icon_name="overamplified"
    elif [ ${1} -ge 67 ]
    then
        icon_name="high"
    elif [ ${1} -ge 33 ]
    then
        icon_name="medium"
    else
        icon_name="low"
    fi
    get_icon_by_name "${icon_name}"
}

readonly LEVEL="$(amixer -c 1 -M -D pulse get Master | grep --only-matching --max-count 1 --perl-regexp '\d+%' | tr --complement --delete "[:digit:]")"
notify-send --expire-time 2000 \
    --icon "$(get_icon_by_level ${LEVEL})" \
    --hint int:value:${LEVEL} \
    "Volume ${LEVEL}%"
