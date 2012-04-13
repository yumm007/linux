#!/bin/bash

LOG_FILE="../log/2012-04-10-location.log"

echo 'set terminal png truecolor' > conf
echo 'set output "T01_Scan.png"' >> conf
echo 'set term pngcairo size 1300,2880' >> conf
echo 'set multiplot layout 10,1' >> conf
echo 'set autoscale' >> conf
echo 'set xdata time' >> conf
echo 'set timefmt "%H:%M:%S"' >> conf
echo 'set style data lines' >> conf

for i in `cat t01.list` 
do
	grep "\[$i\]" $LOG_FILE | ./collect_ap > tmp_dir/$i.log
	echo 'set title "'$i'"' >> conf
	echo 'plot "tmp_dir/'$i'.log" using 1:2 title "AP1", '\'\' 'using 1:3 title "AP2"' >>conf
done

cat conf | gnuplot
rm -rf conf

