#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS -- VCF
#ENV VARS -- VEP_FIELDS
#ENV VARS -- VARS_TSV
#ENV VARS -- ID
#ENV VARS -- OUTPUTDIR
#ENV VARS -- SERVICE detect-variants/final

vep-annotation-reporter -t "${VARS_TSV}" -o "${OUTPUTDIR}/${SERVICE}/${ID}.annotated.tsv" "${VCF}" ${VEP_FIELDS}
