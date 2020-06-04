#!/bin/bash

#ENVVAR OUTPUT
#ENVVAR SERVICE
#@ARGS pindel/deletions, pindel/insertions, pindel/tandems, pindel/long_insertions, pindel/inversions

set -o errexit
set -o nounset

for i in "$@"
do

  /bin/cat $i >> "${WRKDIR}per_chromosome_pindel.out"

done
