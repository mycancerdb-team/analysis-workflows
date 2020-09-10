#!/bin/bash
set -o errexit
set -eou pipefail


#ENV VARS
# OUTPUTDIR
# EPITOPE_LENGTH
# THREADS
# NRML_SMPL_NME
# TUMR_SMPL_NME
# PHASED_VCF
# INPUT_VCF
# ALLELES
# PREDICTION_ALGO

TMPDIR="${OUTPUTDIR}/pvacseq/temp"
ALLELIST=$(cat "${ALLELES}")

pushd "${OUTPUTDIR}/pvacseq"
#link tempdir structure
ln -s $TMPDIR /tmp/pvacseq && export TMPDIR=/tmp/pvacseq \
&&  /opt/conda/bin/pvacseq run --iedb-install-directory /opt/iedb --pass-only -e${EPITOPE_LENGTH} --n-threads ${THREADS} --normal-sample-name ${NRML_SMPL_NME} \
-p ${PHASED_VCF} ${INPUT_VCF} ${TUMR_SMPL_NME} $ALLELIST ${PREDICTION_ALGO} pvacseq_predictions
