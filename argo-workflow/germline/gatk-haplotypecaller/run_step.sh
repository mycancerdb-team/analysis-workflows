#!/bin/bash

#ENV VARS
## OUTPUTDIR
## REF
## BAM
## INTERVALS "chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY"
## CONTAM_FRAC
## EMITREF_CONFI

set -o pipefail
set -o errexit

for c in ${INTERVALS} ; do printf "${c}\n" >> "/root/chromo_list.txt" ; done

haplowrkflw () {
  pushd "${OUTPUTDIR}/normal_final/haplotyper" && mkdir -p "${OUTPUTDIR}/normal_final/haplotyper/$1" && popd
  pushd "${OUTPUTDIR}/normal_final/haplotyper/$1"
  /usr/bin/java -Xmx8g -jar /opt/GenomeAnalysisTK.jar -T HaplotypeCaller -R $REF -I $BAM -ERC $EMITREF_CONFI -L $1 -contamination $CONTAM_FRAC -o "${OUTPUTDIR}/normal_final/haplotyper/$1/$1.g.vcf.gz"
}
export -f haplowrkflw

genotypewrkflw () {
  /usr/bin/java -Xmx8g -jar /opt/GenomeAnalysisTK.jar -T GenotypeGVCFs -o "${OUTPUTDIR}/normal_final/genotype.vcf.gz" -R $REF $1
}
export -f genotypewrkflw

while read h; do
  sem -j 5 -k "haplowrkflw ${h}" #x is the parallel value TBD h is the chrID
done <"/root/chromo_list.txt"
sem --wait

GVCF=$(for c in ${INTERVALS} ; do printf -- "--variant ${OUTPUTDIR}/normal_final/haplotyper/${c}/${c}.g.vcf.gz " ; done)

genotypewrkflw ${GVCF}
