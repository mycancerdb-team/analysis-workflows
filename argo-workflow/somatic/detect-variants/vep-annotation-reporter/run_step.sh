#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS -- VCF
#ENV VARS -- VEP_FIELDS
#ENV VARS -- VARS_TSV
#ENV VARS -- ID
#ENV VARS -- OUTPUTDIR

vep-annotation-reporter -t "${VARS_TSV}" -o "${OUTPUTDIR}/detect-variants/final/${ID}.annotated.tsv" "${VCF}" ${VEP_FIELDS}
