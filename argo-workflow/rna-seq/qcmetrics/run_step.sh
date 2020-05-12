#!/bin/bash

set -e

set -e

if [ $STRAND == 'first' ]
then
  STRANDVAL="STRAND=SECOND_READ_TRANSCRIPTION_STRAND"
elif [ $STRAND == 'second' ]
then
  STRANDVAL="STRAND=FIRST_READ_TRANSCRIPTION_STRAND"
else
  exit
fi


/usr/bin/java -Xmx16g -jar /opt/picard/picard.jar CollectRnaSeqMetrics O="$OUTPUTDIR/$ID/rna_metrics.txt" CHART="$OUTPUTDIR/$ID/rna_metrics.pdf" REF_FLAT=$REFFLAT RIBOSOMAL_INTERVALS=$RIBOINTS $STRANDVAL I=$BAM
