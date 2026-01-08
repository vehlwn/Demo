#!/bin/bash
readonly DEVICE="/dev/video0"
v4l2-ctl --list-formats-ext --device ${DEVICE}
ffmpeg -hide_banner -f v4l2 -list_formats all -i ${DEVICE}
