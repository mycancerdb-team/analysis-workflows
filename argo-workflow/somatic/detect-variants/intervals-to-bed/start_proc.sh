#!/bin/bash

#ENV VAR INTLIST
#ENV VAR OUTPUTDIR
#ENV VAR SERVICE

set -o pipefail
set -o errexit

/usr/bin/perl /root/run_step.pl $INTLIST > "$OUTPUTDIR/$SERVICE/interval_list.bed"
