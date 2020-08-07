#!/bin/bash

#ENV VCF
#ENV OUTPUTDIR
#ENV MAXNRMLFRQ

set -o errexit
set -o nounset

pushd $OUTPUTDIR/varscan/variants

java -jar /opt/varscan/VarScan.jar processSomatic $VCF #--max-normal-freq $MAXNRMLFRQ
