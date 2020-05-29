#!/bin/bash

set -o pipefail
set -o errexit

for d in ${OUTPUTDIR}/mutect/split-ints/*/; do printf "${d}\n" >> /root/scatter_list.txt ; done

while read i; do /root/mutect2-wrkflw.sh ${i}; done </root/scatter_list.txt
