#!/bin/bash

#ENV VARS
##OUTPUTDIR
##SERVICE
##INTLIST
##SCTTRCNT

#run split interval list w. scatter
/usr/bin/java -jar /usr/picard/picard.jar IntervalListTools OUTPUT="${OUTPUTDIR}/${SERVICE}/split-beds" INPUT=${INTLIST} SCATTER_COUNT=${SCTTRCNT}

#enumerate the scatter dirs into a list
for d in ${OUTPUTDIR}/${SERVICE}/split-beds/*/; do printf "${d}\n" >> /root/scatter_list.txt ; done

#loop over the dirs and create bed files for the interval_lists
while read i; do
  /usr/bin/java -jar /usr/picard/picard.jar IntervalListToBed INPUT=${i}scattered.interval_list OUTPUT=${i}scattered.bed &
done </root/scatter_list.txt
echo -n "waiting for parallel execution to complete ... "
wait

mv /root/scatter_list.txt ${OUTPUTDIR}/${SERVICE}/scatter_list.txt
:
