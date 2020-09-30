#!/bin/bash

# $VAULT_ENDPOINT is an env var
DATE=$(date +"%Y%m%d")
VAULT_OUTPATH="Workflow_Results/${DATE}"
DATA_SYNC_DIR="/data/output/"

aws s3 cp ${DATA_SYNC_DIR} "$VAULT_ENDPOINT/${VAULT_OUTPATH}/" --recursive
:
