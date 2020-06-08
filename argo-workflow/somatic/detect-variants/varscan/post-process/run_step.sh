#!/bin/bash

set -o errexit
set -o nounset

for i in "$@"
do
  ##BGZIP
  /opt/htslib/bin/bgzip -f $i

  ##Index
  pushd "$OUTPUTDIR/varscan/variants"
  /usr/bin/tabix -p "vcf" "${i}.gz"
done
