#!/bin/bash

set -o pipefail
set -o errexit

pushd "$OUTPUT/$SERVICE/"
/usr/bin/tabix -p "vcf" $VCF
