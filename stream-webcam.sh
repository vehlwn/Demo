#!/bin/bash

~/ffmpeg -s 640x480 -framerate 30 -thread_queue_size 1024 -i /dev/video0 -f pulse -thread_queue_size 1024 -i default -vcodec h264_nvenc -acodec aac -f mpegts - | cvlc -vvv -I dummy - --sout '#rtp{sdp=rtsp://0.0.0.0:5000/,proto=tcp}' --sout-rtsp-user user --sout-rtsp-pwd 111111
