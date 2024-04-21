#!/usr/bin/sh 

iwctl station "$1" show \
| tail -n +5 \
| sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g;/^\s*$/d' \
| sd '   +' '|' \
| awk -F "|" '
	BEGIN {print "{"}; 
	{print "\""$2"\": \""$3"\","};
	END {print"\"eof\":0}"}' \
| jq