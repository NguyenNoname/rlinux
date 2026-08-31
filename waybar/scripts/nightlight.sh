#!/bin/bash
if pgrep -x "wlsunset" > /dev/null; then
    pkill wlsunset
    notify-send "Night Light" "🔴 Đã TẮT chống mỏi mắt" -u low -t 1500
else
    wlsunset -T 6000 -t 4000 &
    notify-send "Night Light" "🟢 Đã BẬT chống mỏi mắt (Tone ấm)" -u low -t 1500
fi
