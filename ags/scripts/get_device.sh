#!/usr/bin/sh 

iwctl device list \
| tail -n +5 \
| sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g;/^\s*$/d' \
| awk '{print $1}'

