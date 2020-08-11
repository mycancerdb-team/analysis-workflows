#!/bin/bash

set -o pipefail
set -o errexit

#ENVVAR OUTPUTDIR


#enumerate the scattered dirs into a list
#Split list in half
for d in /data/output/pindel/split-beds/*/; do printf "${d}\n" >> "${OUTPUTDIR}/pindel/scatter_list.txt" ; done \
&& sed -n '1,25p' "${OUTPUTDIR}/pindel/scatter_list.txt" > "${OUTPUTDIR}/pindel/head_list.txt" && sed -n '26,50p' "${OUTPUTDIR}/pindel/scatter_list.txt" > "${OUTPUTDIR}/pindel/tail_list.txt"
:
