#!/bin/bash
set -o errexit
set -eou pipefail


#ENV VARS
# OUTPUTDIR
# VCF
# OLDNAME
# NEWNAME
# ID
# SVC

#escape spaces, otherwise bcftools will try to use them as a delimiter
#triple backslash to escape within backticks and then again within sed
old_name=`echo "${OLDNAME}" | sed 's/ /\\\ /g'`
new_name=`echo "${NEWNAME}" | sed 's/ /\\\ /g'`

echo "$old_name $new_name" > /root/sample_update.txt
/opt/bcftools/bin/bcftools reheader -s /root/sample_update.txt -o "${OUTPUTDIR}/${SVC}/${ID}_renamed.vcf.gz" "${VCF}"
