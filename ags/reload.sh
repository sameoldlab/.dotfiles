#!/usr/bin/env -S bash

# while true; do

while inotifywait -e modify,create,delete --recursive .; do # && \
  ags quit -i niri; ags run &
done
