#!/bin/bash
ffmpeg -vaapi_device /dev/dri/renderD128 -f pulse -i default -s 640x480 -framerate 30 -i /dev/video0 -c:v h264_vaapi -vf 'format=nv12,hwupload' -c:a aac -f mpegts - | cvlc -vvv -I dummy - --sout '#rtp{sdp=rtsp://0.0.0.0:5000/}' --sout-rtsp-user user --sout-rtsp-pwd 111111
