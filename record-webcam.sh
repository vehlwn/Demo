#!/bin/bash
ffmpeg -y \
    -f video4linux2 -video_size 1280x720 -framerate 30 -thread_queue_size 1024 -input_format mjpeg -i /dev/video0 \
    -f pulse -thread_queue_size 1024 -i alsa_input.pci-0000_05_00.6.analog-stereo \
    -codec:v h264_nvenc -codec:a aac output.mkv
