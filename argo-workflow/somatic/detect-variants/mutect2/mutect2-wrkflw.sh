#!/usr/bin/parallel --shebang-wrap -jTHREADS --ungroup -k /bin/bash

set -o pipefail
set -o errexit

export tumor_bam="$3"
export normal_bam="$4"

TUMOR=`perl -e 'my $header_str = qx(samtools view -H $ENV{tumor_bam}); my ($sample_name) = $header_str =~ /SM:([ -~]+)/; print $sample_name'` #Extracting the sample name from the TUMOR bam.
NORMAL=`perl -e 'my $header_str = qx(samtools view -H $ENV{normal_bam}); my ($sample_name) = $header_str =~ /SM:([ -~]+)/; print $sample_name'` #Extracting the sample name from the NORMAL bam.
/gatk/gatk Mutect2 --java-options "-Xmx20g" -O ${1}mutect.vcf.gz -R $REFGENOME -I $CANCERBAM -tumor "$TUMOR" -I $NORMALBAM -normal "$NORMAL" -L ${1}scattered.interval_list #Running Mutect2.
/gatk/gatk FilterMutectCalls -R $REFGENOME -V ${1}mutect.vcf.gz -O ${1}mutect.filtered.vcf.gz #Running FilterMutectCalls on the output vcf.
