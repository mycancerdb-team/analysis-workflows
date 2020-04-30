#!/bin/bash

set -e

./convert_fg.sh
RGLIST=$(cat /root/rgvals.txt)

if [ $STRAND == 'first' ]
then
  STRANDVAL="--rna-strandness RF"
elif [ $STRAND == 'second' ]
then
  STRANDVAL="--rna-strandness FR"
else
  exit
fi

/usr/bin/hisat2 -p $THREADS --rg-id $READGRP $RGLIST -x $REFINDEX --dta ${STRANDVAL} -1 $FASTQ1 -2 $FASTQ2 | \
/usr/bin/sambamba view -S -f bam -l 0 /dev/stdin | /usr/bin/sambamba sort -t $THREADS -m 8G -o $OUTPUTDIR/aligned.bam /dev/stdin
