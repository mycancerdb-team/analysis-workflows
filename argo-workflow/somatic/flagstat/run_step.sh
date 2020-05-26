#!/bin/bash

#ENV VARIABLES
#OUTPUTDIR
#DATATYPE
#BAM

set -o pipefail
set -o errexit

/opt/samtools/bin/samtools flagstat $BAM > "$OUTPUDIR/${DATATYPE}_final/$DATATYPE.flagstat"
