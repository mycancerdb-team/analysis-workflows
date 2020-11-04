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
# BINDING_THRSHLD
# DWNSTREAM_SQ_LNGTH
# MIN_FOLD_CHNGE
# NET_CHOP_MTHD
# PEP_SEQ_LNGTH
# TOP_SCORE_MTRC

TMPDIR="${OUTPUTDIR}/pvacseq/temp"
ALLELIST=$(cat "${ALLELES}")

pushd "${OUTPUTDIR}/pvacseq"
#link tempdir structure
ln -s $TMPDIR /tmp/pvacseq && export TMPDIR=/tmp/pvacseq \
&&  /opt/conda/bin/pvacseq run --iedb-install-directory /opt/iedb --pass-only -b ${BINDING_THRSHLD} -d ${DWNSTREAM_SQ_LNGTH} -e${EPITOPE_LENGTH} -k -c ${MIN_FOLD_CHNGE} --n-threads ${THREADS} --net-chop-method ${NET_CHOP_MTHD} --netmhc-stab --normal-sample-name ${NRML_SMPL_NME} \
-l ${PEP_SEQ_LNGTH} -p ${PHASED_VCF} -m ${TOP_SCORE_MTRC} ${INPUT_VCF} ${TUMR_SMPL_NME} $ALLELIST ${PREDICTION_ALGO} pvacseq_predictions
