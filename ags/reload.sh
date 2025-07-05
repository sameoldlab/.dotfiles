#!/usr/bin/env -S bash

# while true; do

while inotifywait -e modify,create,delete --recursive ./base; do # && \
  ags quit -i niri; ags run --gtk 3 &
done
