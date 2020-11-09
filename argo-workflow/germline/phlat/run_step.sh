#!/bin/bash
set -o errexit
set -eou pipefail

#SMPLE #mcdb000-normal-exome
#BAM #/data/output/normal_final/normal_mcdb000.bam

mkdir -p "$SMPLE/results"

tmpdir=$SMPLE/tmp
mkdir -p $tmpdir

phlatdir=/opt/phlat-release
datadir=$SMPLE
indexdir=/ref-hg38/phlat-release
rsdir=$SMPLE/results
b2url=/usr/local/bin/bowtie2
tag=$SMPLE
fastq1="hlaPlusUnmapped_1.fastq.gz"
fastq2="hlaPlusUnmapped_2.fastq.gz"
#REF_FILE #/ref-hg38/reference_genome/all_sequences.fa

#extract hla regions and unmapped reads
samtools view -h -T $REF_FILE $BAM chr6:29836259-33148325 >>$tmpdir/reads.sam
samtools view -H -T $REF_FILE $BAM | grep "^@SQ" | cut -f 2 | cut -f 2- -d : | grep HLA | while read chr;do

# echo "checking $chr:1-9999999"
samtools view -T $REF_FILE $BAM "$chr:1-9999999" >>$tmpdir/reads.sam
done

# filter reads with flags 4 and convert to bam
samtools view -f 4 -T $REF_FILE $BAM >>$tmpdir/reads.sam
samtools view -Sb -o $tmpdir/reads.bam $tmpdir/reads.sam

# Create fastq files from bam
/usr/bin/java -Xmx6g -jar /usr/picard/picard.jar SamToFastq VALIDATION_STRINGENCY=LENIENT F=$SMPLE/hlaPlusUnmapped_1.fastq.gz F2=$SMPLE/hlaPlusUnmapped_2.fastq.gz I=$tmpdir/reads.bam R=$REF_FILE FU=$SMPLE/unpaired.fastq.gz

#workaround to get everything passed in appropriately
echo "python -O ${phlatdir}/dist/PHLAT.py -1 ${datadir}/${fastq1} -2 ${datadir}/${fastq2} -index $indexdir -b2url $b2url -orientation "--fr" -tag $tag -e $phlatdir -o $rsdir -tmp 0 -p 4" >$SMPLE/run_phlat.sh

python -O ${phlatdir}/dist/PHLAT.py -1 ${datadir}/${fastq1} -2 ${datadir}/${fastq2} -index $indexdir -b2url $b2url -orientation "--fr" -tag $tag -e $phlatdir -o $rsdir -tmp 0
