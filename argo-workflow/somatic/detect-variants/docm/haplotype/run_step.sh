#!/bin/bash

set -o pipefail
set -o errexit

# Running haplotype caller using the newly created interval list
if [[ "$#" == 5 ]];then # If normal_bam is passed.
    # explicitly capturing variables
    reference=$1
    normal_bam=$2
    tumor_bam=$3
    docm_vcf=$4
    interval_list=$5
    # Chaning the interval_list to a new docm_interval_list that spans the docm regions by 200bp
    cat $interval_list | grep '^@' > docm.interval_list # Extracting the header from the interval_list
    zcat $docm_vcf | grep ^chr | awk '{FS = "\t";OFS = "\t";print $1,$2-100,$2+100,"+",$1"_"$2-100"_"$2+100}' >> docm.interval_list # Extracting the docm regions with a 100bp flanking region on both directions
    /gatk/gatk HaplotypeCaller --java-options "-Xmx8g" -R $reference -I $normal_bam -I $tumor_bam --alleles $docm_vcf -L docm.interval_list --genotyping-mode GENOTYPE_GIVEN_ALLELES -O "$OUTPUTDIR/docm/raw/docm_raw_variants.vcf"
else # If normal_bam is not passed
    reference=$1
    tumor_bam=$2
    docm_vcf=$3
    interval_list=$4
    # Chaning the interval_list to a new docm_interval_list that spans the docm regions by 200bp
    cat $interval_list | grep '^@' > docm.interval_list # Extracting the header from the interval_list
    zcat $docm_vcf | grep ^chr | awk '{FS = "\t";OFS = "\t";print $1,$2-100,$2+100,"+",$1"_"$2-100"_"$2+100}' >> docm.interval_list # Extracting the docm regions with a 100bp flanking region on both directions
    /gatk/gatk HaplotypeCaller --java-options "-Xmx8g" -R $reference -I $tumor_bam --alleles $docm_vcf -L docm.interval_list --genotyping-mode GENOTYPE_GIVEN_ALLELES -O "$OUTPUTDIR/docm/raw/docm_raw_variants.vcf"
fi
