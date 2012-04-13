#!/bin/bash

LOG_FILE=$1
cut -b 22-26 $LOG_FILE | sort | uniq > t01.list
n=`wc -l t01.list | cut -b -2`
w=$n*280

cut -d';' -f 2,4 $LOG_FILE | sed "s/;/\n/" | cut -b 3- | sort | uniq > ap.list
sed -i '/000000/d' ap.list

if [ ! -d tmp_dir ]; then
	mkdir tmp_dir
fi

echo 'set terminal png truecolor' > conf
echo 'set output "T01_Scan.png"' >> conf
echo 'set term pngcairo size 1300,'$w >> conf
echo 'set multiplot layout '$n',1' >> conf
echo 'set autoscale' >> conf
echo 'set xdata time' >> conf
echo 'set timefmt "%H:%M:%S"' >> conf
echo 'set style data lines' >> conf

n=`wc -l ap.list | cut -b -2`

for i in `cat t01.list` 
do
	grep "\[$i\]" $LOG_FILE | ./collect_ap > tmp_dir/$i.log
	echo 'set title "'$i'"' >> conf
	echo -n 'plot "tmp_dir/'$i'.log" ' >> conf
	for ((j = 2; j < $n+1; j++))
	do
		echo -n ' using 1:'$j', '\'\'' ' >> conf
	done
		echo  ' using 1:'$j >> conf
done

cat conf | gnuplot
rm -rf conf ap.list t01.list tmp_dir/

