#!/bin/bash

set -o pipefail
set -o errexit
set -o nounset

/opt/htslib/bin/bgzip -f $INPUTFILE
