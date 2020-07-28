#!/bin/bash

#ENVVARS
#OUTPUTDIR
#SVC
#ID
#SAMPLEID

set -eou pipefail
basen="renamed_${SAMPLEID}.vcf.gz"

#make sure we enter the correct dir to obtain outputs.
pushd "${OUTPUTDIR}/${SVC}/rename"
#escape spaces, otherwise bcftools will try to use them as a delimiter
#triple backslash to escape within backticks and then again within sed
old_name=`echo "$1" | sed 's/ /\\\ /g'`
new_name=`echo "$2" | sed 's/ /\\\ /g'`

echo "$old_name $new_name" > sample_update.txt
/opt/bcftools/bin/bcftools reheader -s sample_update.txt -o "$basen" "$3"
