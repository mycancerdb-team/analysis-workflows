#!/bin/bash

set -o pipefail
set -o errexit

for f in ${OUTPUTDIR}/mutect/split-ints/*/; do printf "${f}mutect.filtered.vcf.gz " >> /root/dir.txt ; done
VCFS=$(cat /root/dir.txt)
##Merge VCFs
/opt/bcftools/bin/bcftools concat --allow-overlaps --remove-duplicates --output-type "z" -o $OUTPUTDIR/mutect/${ID}.vcf.gz $VCFS
