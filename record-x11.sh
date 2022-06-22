#!/bin/bash
ffmpeg -y \
    -f x11grab -video_size 1920x1080 -framerate 60 -i :0 \
    -f pulse -i alsa_output.pci-0000_05_00.6.analog-stereo.monitor \
    -codec:v h264_nvenc -codec:a aac -b:v 8M output.mp4
