#!/bin/bash
watch -n 5 'grep -v "TOTAL" online.log  |sed "s/\t/\n/g" | grep -v "^$" | grep ON | sort -n | uniq -c '


