#!/bin/bash

set -o pipefail
set -o errexit

if [[ "$DATATYPE" == 0 ]];
then
  #If $DATATYPE IS NULL do this
  pushd "$OUTPUT/$SERVICE"
  /usr/bin/tabix -f -p "vcf" $VCF
else
  pushd "$OUTPUT/$SERVICE/$DATATYPE"
  /usr/bin/tabix -f -p "vcf" $VCF
fi
