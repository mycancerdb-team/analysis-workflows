#!/bin/bash

#ENVVAR OUTPUT
#ENVVAR PINDELFILE
#ENVVAR SERVICE
#ENVVAR REF


set -o errexit
set -o nounset

/usr/bin/perl /usr/bin/write_pindel_filter_config.pl $PINDELFILE $REF "$OUTPUT/$SERVICE" && \
/usr/bin/perl /usr/bin/somatic_indelfilter.pl filter.config
