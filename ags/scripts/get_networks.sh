#!/usr/bin/sh 

iwctl station "$1" get-networks \
| grep psk \
| sd '\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]' '  '\
| sd '>' ' ' \
| sd '  +' '|' \
| awk -F "|" '{print "{\"name\":\""$2"\", \"signal\":"length($4)"}"}'