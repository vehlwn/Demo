#!/bin/bash

# https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/
# https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_Streaming_Using_the_Command_Line
ffmpeg \
    -f video4linux2 -video_size 1280x720 -framerate 30 -thread_queue_size 1024 -input_format mjpeg -i /dev/video0 \
    -f pulse -thread_queue_size 1024 -i alsa_input.pci-0000_05_00.6.analog-stereo \
    -f mpegts -vcodec h264_nvenc -acodec aac - \
    | cvlc -I dummy - --sout '#rtp{sdp=rtsp://0.0.0.0:5000/,proto=udp}' --sout-rtsp-user user --sout-rtsp-pwd 111111
