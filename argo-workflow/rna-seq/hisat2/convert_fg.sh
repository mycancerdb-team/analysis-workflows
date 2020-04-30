#!/bin/bash

#READGRPFIELDS system env-var
for val in $READGRPFIELDS; do
  echo -n "--rg ${val} " >> /root/rgvals.txt
done
