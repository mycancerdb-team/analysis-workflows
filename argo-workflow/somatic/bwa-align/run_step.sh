#!/bin/bash

set -o pipefail
set -o errexit
set -o nounset

while getopts "b:?1:?2:?g:r:n:" opt; do
    case "$opt" in
        b)
            MODE=bam
            BAM="$OPTARG"
            ;;
        1)
            MODE=fastq
            FASTQ1="$OPTARG"
            ;;
        2)
            MODE=fastq
            FASTQ2="$OPTARG"
            ;;
        g)
            READGROUP="$OPTARG"
            ;;
        r)
            REFERENCE="$OPTARG"
            ;;
        n)
            NTHREADS="$OPTARG"
            ;;
    esac
done

if [[ "$MODE" == 'fastq' ]]; then
    /usr/local/bin/bwa mem -K 100000000 -t "$NTHREADS" -Y -R "$READGROUP" "$REFERENCE" "$FASTQ1" "$FASTQ2" | /usr/local/bin/samblaster -a --addMateTags | /opt/samtools/bin/samtools view -b -S /dev/stdin > "$OUTPUTDIR/${DATATYPE}_bwa/$DATATYPE-aligned.bam"
fi
if [[ "$MODE" == 'bam' ]]; then
    /usr/bin/java -Xmx25g -jar /opt/picard/picard.jar SamToFastq I="$BAM" INTERLEAVE=true INCLUDE_NON_PF_READS=true FASTQ=/dev/stdout | /usr/local/bin/bwa mem -K 100000000 -t "$NTHREADS" -Y -p -R "$READGROUP" "$REFERENCE" /dev/stdin | /usr/local/bin/samblaster -a --addMateTags | /opt/samtools/bin/samtools view -b -S /dev/stdin > "$OUTPUTDIR/${DATATYPE}_bwa/$DATATYPE-aligned.bam"
fi
