#!/bin/bash
watch -n 5 'grep -v "TOTAL" log/2012-05-17-online.log  |sed "s/\t/\n/g" | grep -v "^$" | grep ON | sort -n | uniq -c '


