#!/bin/bash
ffmpeg -vaapi_device /dev/dri/renderD128 -f pulse -i alsa_output.pci-0000_06_00.6.analog-stereo.monitor -f x11grab -s 1920x1080 -framerate 60 -i :0 -codec:v h264_vaapi -vf 'hwupload,scale_vaapi=format=nv12' -c:a aac -f mpegts - | cvlc -vvv -I dummy - --sout '#rtp{sdp=rtsp://0.0.0.0:5000/}' --sout-rtsp-user user --sout-rtsp-pwd 111111
