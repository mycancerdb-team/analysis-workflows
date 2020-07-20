#!/bin/bash

set -eou pipefail

#ENV
#OUTPUTDIR
#SVC
#ID

# 1) removes lines containing non ACTGN bases, as they conflict with the VCF spec
# and cause GATK to choke
# 2) removes mutect-specific format tags containing underscores, which are likewise
# illegal in the vcf spec
base=`basename $1`
outbase=`echo $base | perl -pe 's/.vcf(.gz)?$//g'`
echo "$1   $base    $outbase"
if [[ "$1" =~ ".gz" ]];then
    #gzipped input
    gunzip -c "$1" | perl -a -F'\t' -ne 'print $_ if $_ =~ /^#/ || $F[3] !~ /[^ACTGNactgn]/' | sed -e "s/ALT_F1R2/ALTF1R2/g;s/ALT_F2R1/ALTF2R1/g;s/REF_F1R2/REFF1R2/g;s/REF_F2R1/REFF2R1/g" >"${OUTPUTDIR}/${SVC}/sani/${ID}.sanitized.vcf"
else
    #non-gzipped input
    cat "$1" | perl -a -F'\t' -ne 'print $_ if $_ =~ /^#/ || $F[3] !~ /[^ACTGNactgn]/' | sed -e "s/ALT_F1R2/ALTF1R2/g;s/ALT_F2R1/ALTF2R1/g;s/REF_F1R2/REFF1R2/g;s/REF_F2R1/REFF2R1/g" >"${OUTPUTDIR}/${SVC}/sani/${ID}.sanitized.vcf"
fi
/opt/htslib/bin/bgzip "${OUTPUTDIR}/${SVC}/sani/${ID}.sanitized.vcf"
/usr/bin/tabix -p vcf "${OUTPUTDIR}/${SVC}/sani/${ID}.sanitized.vcf.gz"
