#!/bin/bash

# $VAULT_ENDPOINT is an env var s3://vault000-mycancerdb
# $PATIENT_ID is an env var #MDB000
# $GENOMIC_PATH is an env var /genomic/us-east-2:ce8dfa06-3409-4d96-903f-d0d8204073bd/

OUTPUTDIR="/data"

date
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-exome/" "${OUTPUTDIR}/samples/cancer-exome/" --recursive
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/somatic-exome/" "${OUTPUTDIR}/samples/somatic-exome/" --recursive
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-rna/" "${OUTPUTDIR}/samples/cancer-rna/" --recursive
mkdir -p ${OUTPUTDIR}/output/trimmed_read
date
:
