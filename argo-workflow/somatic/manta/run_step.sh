#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS
# REFGENOME
# CANCERBAM
# NORMALBAM
# OUTPUTDIR

pushd "${OUTPUTDIR}/manta"
/usr/bin/manta/bin/configManta.py --exome --referenceFasta "${REFGENOME}" --tumorBam "${CANCERBAM}" --normalBam "${NORMALBAM}" \
&& /usr/bin/python "${OUTPUTDIR}/manta/MantaWorkflow/runWorkflow.py" -m local -j 12
