#!/bin/bash

set -o pipefail
set -o errexit

#ENVVAR CANCERBAM
#ENVVAR NORMALBAM
#ENVVAR INSRTSIZE
#ENVVAR CANCERNAME
#ENVVAR NORMALNAME
#ENVVAR REF
#ENVVAR CHROMO
#ENVVAR OUTPUTDIR

for d in ${OUTPUTDIR}/pindel/split-beds/*/; do printf "${d}\n" >> /root/scatter_list.txt ; done

while read i; do
pushd ${i} && /usr/bin/perl /root/run_step.pl $CANCERBAM $NORMALBAM $INSRTSIZE $CANCERNAME $NORMALNAME -f $REF -c $CHROMO -j "${i}scattered.interval_list" && \
export WRKDIR=${i} && /root/cat-out.sh "${i}all_D" "${i}all_SI" "${i}all_TD" "${i}all_LI" "${i}all_INV" && popd;
done </root/scatter_list.txt


while read i; do
  /bin/cat "${i}per_chromosome_pindel.out" | /bin/grep ChrID /dev/stdin >> "${OUTPUTDIR}/pindel/all_region_pindel.head";
done </root/scatter_list.txt
