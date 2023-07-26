#!/bin/bash
set -e

# https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/
# https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_Streaming_Using_the_Command_Line
# https://trac.ffmpeg.org/wiki/Hardware/VAAPI
ffmpeg \
    -hide_banner \
    -vaapi_device /dev/dri/renderD128 \
    -f video4linux2 -video_size 1280x720 -framerate 30 -thread_queue_size 128 -input_format mjpeg -i /dev/video0 \
    -f pulse -thread_queue_size 128 -i default \
    -f mpegts \
    -vcodec h264_vaapi -b:v 5M -g 15 -flags +cgop \
    -acodec aac -b:a 128K \
    -filter_complex "
        drawtext=text='%{localtime\\:%F %T} n=%{frame_num}' :box=1 :boxcolor=black@0.2 :boxborderw=2 :fontcolor=white :fontsize=28 :x=10 :y=10
        ,format=nv12
        ,hwupload
        " \
    - \
    | cvlc -I dummy - --sout '#rtp{sdp=rtsp://:5000/,proto=udp}'
