#!/bin/bash

# $VAULT_ENDPOINT is an env var
DATE=$(date +"%Y%m%d")
VAULT_OUTPATH="Workflow_Results/${DATE}"
DATA_SYNC_DIR="/data/output/"

#Generate results package
## create archive of pvacseq outputs
pushd ${DATA_SYNC_DIR}
zip ${DATA_SYNC_DIR}/${PATIENT_ID}_pvac_results.zip ${DATA_SYNC_DIR}/final/mhc_1/ ${DATA_SYNC_DIR}/final/mhc_2/ ${DATA_SYNC_DIR}/final/pvacseq/ -r
popd
#Generate VCF package
## create collection of relevant dirs into zip file
## strelka, mutect, varscan, docom, pindel, cnvkit, detect-variants

aws s3 cp ${DATA_SYNC_DIR} "$VAULT_ENDPOINT/${VAULT_OUTPATH}/" --recursive
## generate temp link
aws s3 presign "$VAULT_ENDPOINT/${VAULT_OUTPATH}/${PATIENT_ID}_pvac_results.zip" --expires-in 259200 --region us-east-2

##hit notification system with complete message
### include 2 secure links to grab the files directly or include vault locations

:
