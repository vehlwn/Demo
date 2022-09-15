#!/bin/bash
ffmpeg -y \
    -f x11grab -video_size 1920x1080 -framerate 60 -thread_queue_size 1024 -probesize 20M -i :0 \
    -f pulse -thread_queue_size 1024 -i alsa_output.pci-0000_05_00.6.analog-stereo.monitor \
    -f pulse -thread_queue_size 1024 -i default \
    -map 0:v -map 1:a -map 2:a \
    -metadata:s:a:0 title=alsa_output \
    -metadata:s:a:1 title="default input" \
    -codec:v h264_nvenc -b:v 8M -codec:a aac -b:a 128K output.mp4
