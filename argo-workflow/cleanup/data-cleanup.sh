#!/bin/bash

# $VAULT_ENDPOINT is an env var
VAULT_OUTPATH="mgbio_run/${DATE}"
DATE=$(date +"%Y%m%d")
DATA_SYNC_DIR="/data/output/"

aws s3 cp ${DATA_SYNC_DIR} "$VAULT_ENDPOINT/${VAULT_OUTPATH}/" --recursive
:
