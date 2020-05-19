#!/bin/bash

set -e

if [ $STRAND == 'first' ]
then
  STRANDVAL="--rf"
elif [ $STRAND == 'second' ]
then
  STRANDVAL="--fr"
else
  exit
fi

echo -n "Running stringtie ... "

/usr/bin/stringtie -o "$OUTPUTDIR/${SAMPLE_NAME}_final/${SAMPLE_NAME}_stringtie_transcripts.gtf" -A "$OUTPUTDIR/${SAMPLE_NAME}_final/${SAMPLE_NAME}_stringtie_gene_expression.tsv" -p $THREADS -e ${STRANDVAL} -G $REF_ANNOTATION -l $SAMPLE_NAME $BAM
echo -n "Processing complete ... "
date
