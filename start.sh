#!/bin/sh
  
if [ -z "$VNC_PASSWORD" ]; then
    echo "VNC_PASSWORD is 1234"
    VNC_PASSWORD=1234
fi

mkdir -p ~/.vnc
x11vnc -storepasswd $VNC_PASSWORD ~/.vnc/passwd

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
