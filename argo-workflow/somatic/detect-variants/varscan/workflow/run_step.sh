#!/bin/bash

set -o errexit
set -o nounset

TUMOR_BAM="$TUMORBAM"
NORMAL_BAM="$NORMALBAM"
REFERENCE="$REF"
STRAND_FILTER="$STRNDFLTR"
MIN_COVERAGE="$MINCVRGE"
MIN_VAR_FREQ="$MINVARFRQ"
P_VALUE="$PVALUE"
OUTPUT="${OUTPUTDIR}/varscan/variants/output"

if [ -z ${ROIBED+x} ]
then
    #run without ROI
    java -jar /opt/varscan/VarScan.jar somatic \
        <(/opt/samtools/bin/samtools mpileup --no-baq -f "$REFERENCE" "$NORMAL_BAM" "$TUMOR_BAM") \
        $OUTPUT \
        --strand-filter $STRAND_FILTER \
        --min-coverage $MIN_COVERAGE \
        --min-var-freq $MIN_VAR_FREQ \
        --p-value $P_VALUE \
        --mpileup 1 \
        --output-vcf
else
    ROI_BED="$ROIBED"
    java -jar /opt/varscan/VarScan.jar somatic \
        <(/opt/samtools/bin/samtools mpileup --no-baq -l "$ROI_BED" -f "$REFERENCE" "$NORMAL_BAM" "$TUMOR_BAM") \
        $OUTPUT \
        --strand-filter $STRAND_FILTER \
        --min-coverage $MIN_COVERAGE \
        --min-var-freq $MIN_VAR_FREQ \
        --p-value $P_VALUE \
        --mpileup 1 \
        --output-vcf
fi
