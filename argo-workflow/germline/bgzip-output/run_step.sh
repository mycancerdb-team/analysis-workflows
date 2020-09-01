#!/bin/bash

set -o pipefail
set -o errexit
set -o nounset

#ENV VARS
#INPUTFILE
#OUTPUTDIR
#ID
#FNAME

/opt/htslib/bin/bgzip $INPUTFILE >> "${OUTPUTDIR}/normal_final/germline-filter/${ID}_${FNAME}.gz"
