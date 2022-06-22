#!/bin/bash

~/ffmpeg \
    -f video4linux2 -video_size 1280x720 -framerate 30 -thread_queue_size 1024 -input_format mjpeg -i /dev/video0 \
    -f pulse -thread_queue_size 1024 -i default \
    -f mpegts -vcodec h264_nvenc -acodec aac - \
    | cvlc -I dummy - --sout '#rtp{sdp=rtsp://0.0.0.0:5000/,proto=tcp}' --sout-rtsp-user user --sout-rtsp-pwd 111111
