#!/bin/bash

#env list
##INPUTFILE
##OUTPUTDIR
##SERVICE


cat ${INPUTFILE}  | jq  --raw-input .  | jq --slurp . > "${INPUTFILE}.json"
