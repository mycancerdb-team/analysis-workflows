#!/bin/bash

set -o pipefail
set -o errexit

#ENVVAR OUTPUTDIR
#ENVVAR SCTTRLIST

while read i; do
  /bin/cat "${i}per_chromosome_pindel.out" | /bin/grep ChrID /dev/stdin >> "${OUTPUTDIR}/pindel/all_region_pindel.head";
done <"${SCTTRLIST}"

:
