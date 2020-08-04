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
#ENVVAR WRKNGDIR


#enumerate the scattered dirs into a list for parsing
for d in ${OUTPUTDIR}/pindel/split-beds/*/; do printf "${d}\n" >> /root/scatter_list.txt ; done

# Pindel function used to invoke pindel per scattered dir and associated bed file
pwrkflw () {
  echo -n "$NORMALBAM $CANCERBAM $INSRTSIZE $NORMALNAME $CANCERNAME -f $REF -c $CHROMO -j ${1}scattered.bed"
  pushd $1 && /usr/bin/perl /root/run_step.pl $NORMALBAM $CANCERBAM $INSRTSIZE $NORMALNAME $CANCERNAME -f $REF -c $CHROMO -j "${1}scattered.bed"
  export WRKDIR=$1 && /root/cat-out.sh "${1}all_INV" "${1}all_TD" "${1}all_D" "${1}all_SI"  "${1}all_LI"  && popd;
}
export -f pwrkflw
##
#pindel $WRKNGDIR
###
#/bin/cat "${WRKNGDIR}per_chromosome_pindel.out" | /bin/grep ChrID /dev/stdin >> "${OUTPUTDIR}/pindel/all_region_pindel.head"

# Invoke pindel function forked and parallelized, wait for all instances to complete before moving on
while read p; do
  sem -j 15 -k "pwrkflw ${p}"
done </root/scatter_list.txt
sem --wait

while read i; do
  /bin/cat "${i}per_chromosome_pindel.out" | /bin/grep ChrID /dev/stdin >> "${OUTPUTDIR}/pindel/all_region_pindel.head";
done </root/scatter_list.txt

:
