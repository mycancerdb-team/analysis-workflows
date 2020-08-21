#!/bin/bash

set -o pipefail
set -o errexit

#ENV VARS -- REF
#ENV VARS -- VCF
#ENV VARS -- FIELDS
#ENV VARS -- GENO_FIELDS
#ENV VARS -- OUTPUTDIR

F=$(for f in ${FIELDS} ; do printf -- "-F ${f} " ; done)
GF=$(for gf in ${GENO_FIELDS} ; do printf -- "-GF ${gf} " ; done)


/usr/bin/java -Xmx8g -jar /opt/GenomeAnalysisTK.jar -T VariantsToTable -R "${REF}" --variant "${VCF}" ${F} \
${GF} --allowMissingData -o "${OUTPUTDIR}/detect-variants/final/variants.tsv"
