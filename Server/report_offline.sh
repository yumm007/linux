#!/bin/bash
watch -n 5 'grep -v "TOTAL" online.log  |sed "s/\t/\n/g" | grep -v "^$" | grep OFF | sort -n | uniq -c '


