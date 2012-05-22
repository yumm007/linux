#!/bin/bash
watch -n 5 'grep -v "TOTAL" log/2012-05-17-location.log  |sed "s/\t/\n/g" | grep -v "^$" | grep OFF | sort -n | uniq -c '


