#!/bin/bash
set -o errexit
set -eou pipefail

#PHLAT_FILE
#OPTI_FILE #consenses_calls
#OUTPUTDIR

echo -n 'Displaying PHLAT generated values ...'
cat ${PHLAT_FILE}
sleep 5

#extract outputs into list ...
tail -3 ${PHLAT_FILE} | awk '{print $2}' | cut -c 1-10 >> /root/list.txt
tail -3 ${PHLAT_FILE} | awk '{print $3}' | cut -c 1-10 >> /root/list.txt
#print all values into comma seperated list
awk -vORS=, '{ print $1 }' /root/list.txt >> /root/mhc2_list.txt
#generate paired values then print into comma seperated list file
grep DQ /root/list.txt | sed -e '1{N;s/\n/-/;}' -e '3{N;s/\n/-/;}' >> /root/paired-list.txt
awk -vORS=, '{ print $1 }' /root/paired-list.txt >> /root/mhc2_list.txt
#combine MHC_2 with MHC_1 consensus_calls.txt
cat /root/mhc2_list.txt ${OPTI_FILE} > ${OUTPUTDIR}/hla/hla_calls/combined_calls.txt
:
