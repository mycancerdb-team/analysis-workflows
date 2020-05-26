#!/bin/bash

set -o pipefail
set -o errexit

for d in ${OUTPUTDIR}/mutect/split-ints/*/; do printf "${d} " >> /root/scatter_list.txt ; done
SCATTER_LIST=$(cat /root/scatter_list.txt)

sed -i "s/THREADS/$PARALLEL/g" /root/mutect2-wrkflw.sh

/root/mutect2-wrkflw.sh $SCATTER_LIST
