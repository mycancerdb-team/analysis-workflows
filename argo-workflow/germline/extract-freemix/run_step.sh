#!/bin/bash

set -o pipefail
set -o errexit

#ENVVAR #VERIFYBAMFILE /data/output/normal_final/normal.VerifyBamId.selfSM
#ENVVAR #OUTPUTDIR

HEADER=$(awk '{print $7}' ${VERIFYBAMFILE} | sed 2d)

if [[ "$HEADER" == 'FREEMIX' ]]; then
  awk '{print $7}' ${VERIFYBAMFILE} | sed 1d >> ${OUTPUTDIR}/normal_final/freemix_score.txt
  exit 0
else
  echo -n "Freemix header not found, found $HEADER instead ... failing"
  exit 1
fi
