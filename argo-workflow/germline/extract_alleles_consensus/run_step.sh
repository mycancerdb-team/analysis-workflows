#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS
#OUTPUTDIR
#OPTITSV

## Extract HLA Alleles
## Create output parameter for /data/output/hla_helper.txt
/usr/bin/awk '{getline; printf "HLA-"$2 " HLA-"$3 " HLA-"$4 " HLA-"$5 " HLA-"$6 " HLA-"$7}' ${OPTITSV} > "${OUTPUTDIR}/hla_helper.txt"
HLA=$(cat "${OUTPUTDIR}/hla_helper.txt")

pushd "${OUTPUTDIR}/hla"
python /root/hla_consensus.py ${HLA}
popd
