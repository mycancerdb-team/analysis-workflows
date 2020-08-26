#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS
#VCF
#OTUPUTDIR

/usr/bin/perl /usr/bin/vcf_check.pl ${VCF} "${OUTPUTDIR}/normal_final/germline-filter/coding_variant_filtered.vcf" && \
/usr/bin/perl /opt/vep/src/ensembl-vep/filter_vep --format vcf -o "${OUTPUTDIR}/normal_final/germline-filter/coding_variant_filtered.vcf" --ontology --filter "Consequence is coding_sequence_variant" -i ${VCF}
