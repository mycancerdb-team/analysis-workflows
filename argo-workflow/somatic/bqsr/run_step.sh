#!/bin/bash

#ENVVAR
##BQSRINT
##REF
##BAM
##KNWNINDELS
##DBSNP
##OUTPUTDIR
##DATATYPE

set -o pipefail
set -o errexit
set -o nounset

/usr/bin/java -Xmx32g -jar /opt/GenomeAnalysisTK.jar -T BaseRecalibrator $BQSRINT -R $REF -I $BAM -knownSites $KNWNINDELS -knownSites $DBSNP \
-o "$OUTPUTDIR/${DATATYPE}_bqsr/${DATATYPE}_bqsr.table" --preserve_qscores_less_than 6 --disable_auto_index_creation_and_locking_when_reading_rods \
--disable_bam_indexing -dfrac .1 -nct 10
