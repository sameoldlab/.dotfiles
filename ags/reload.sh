#!/usr/bin/env -S bash

# while true; do

while inotifywait -e modify,create,delete --recursive ./base; do # && \
  ags quit; ags run &
done
