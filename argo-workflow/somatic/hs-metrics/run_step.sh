#!/bin/bash

#Env Vars
#OUTPUTDIR "{{inputs.parameters.output-dir}}"
#DATATYPE "{{inputs.parameters.data-type}}"
#BAMFILE "{{inputs.parameters.bam-file}}"
#REFGENOME "{{inputs.parameters.reference}}"
#METRICACCUMLVL "{{inputs.parameters.metric-accumulation-level}}"
#BAITINTV "{{inputs.parameters.bait-intervals}}"
#TRGTINTV "{{inputs.parameters.target-intervals}}"
#PERTRGTCVRG "{{inputs.parameters.per_target_coverage}}"
#PERBSECVRG "{{inputs.parameters.per_base_coverage}}"
#OUTPTPRFX "{{inputs.parameters.output_prefix}}"
#MINMPQL "{{inputs.parameters.minimum_mapping_quality}}"
#MINBSQL "{{inputs.parameters.minimum_base_quality}}"

set -e

if [ $PERTRGTCVRG == 'false' && $PERBSECVRG == 'false' ]
then
  #1
  echo -n "Running the HS_Metrics Pipeline for $DATATYPE Exome data with no per target or base coverage calculations ...  "
  /usr/bin/java -Xmx48g -jar /usr/picard/picard.jar CollectHsMetrics O=$OUTPUTDIR/${DATATYPE}_final/${OUTPTPRFX}_${DATATYPE}_HsMetrics.txt I=$BAMFILE R=$REFGENOME \
  METRIC_ACCUMULATION_LEVEL=$METRICACCUMLVL BAIT_INTERVALS=$BAITINTV TARGET_INTERVALS=$TRGTINTV  MINIMUM_MAPPING_QUALITY=$MINMPQL MINIMUM_BASE_QUALITY=$MINBSQL
elif [ $PERTRGTCVRG == 'true' && $PERBSECVRG == 'false' ]
then
  #2
  echo -n "Running the HS_Metrics Pipeline for $DATATYPE Exome data with per target coverage calculations ...  "
  /usr/bin/java -Xmx48g -jar /usr/picard/picard.jar CollectHsMetrics O=$OUTPUTDIR/${DATATYPE}_final/${OUTPTPRFX}_${DATATYPE}_HsMetrics.txt I=$BAMFILE R=$REFGENOME \
  METRIC_ACCUMULATION_LEVEL=$METRICACCUMLVL BAIT_INTERVALS=$BAITINTV TARGET_INTERVALS=$TRGTINTV  MINIMUM_MAPPING_QUALITY=$MINMPQL MINIMUM_BASE_QUALITY=$MINBSQL \
  PER_TARGET_COVERAGE=${OUTPTPRFX}_${DATATYPE}_PerTargetCoverage.txt
elif [ $PERTRGTCVRG == 'false' && $PERBSECVRG == 'true' ]
then
  #3
  echo -n "Running the HS_Metrics Pipeline for $DATATYPE Exome data with base coverage calculations ...  "
  /usr/bin/java -Xmx48g -jar /usr/picard/picard.jar CollectHsMetrics O=$OUTPUTDIR/${DATATYPE}_final/${OUTPTPRFX}_${DATATYPE}_HsMetrics.txt I=$BAMFILE R=$REFGENOME \
  METRIC_ACCUMULATION_LEVEL=$METRICACCUMLVL BAIT_INTERVALS=$BAITINTV TARGET_INTERVALS=$TRGTINTV  MINIMUM_MAPPING_QUALITY=$MINMPQL MINIMUM_BASE_QUALITY=$MINBSQL \
  PER_BASE_COVERAGE=${OUTPTPRFX}_${DATATYPE}_PerBaseCoverage.txt
elif [ $PERTRGTCVRG == 'true' && $PERBSECVRG == 'true' ]
then
  #4
  echo -n "Running the HS_Metrics Pipeline for $DATATYPE Exome data with both per target and base coverage calculations ...  "
  /usr/bin/java -Xmx48g -jar /usr/picard/picard.jar CollectHsMetrics O=$OUTPUTDIR/${DATATYPE}_final/${OUTPTPRFX}_${DATATYPE}_HsMetrics.txt I=$BAMFILE R=$REFGENOME \
  METRIC_ACCUMULATION_LEVEL=$METRICACCUMLVL BAIT_INTERVALS=$BAITINTV TARGET_INTERVALS=$TRGTINTV  MINIMUM_MAPPING_QUALITY=$MINMPQL MINIMUM_BASE_QUALITY=$MINBSQL \
  PER_TARGET_COVERAGE=${OUTPTPRFX}_${DATATYPE}_PerTargetCoverage.txt PER_BASE_COVERAGE=${OUTPTPRFX}_${DATATYPE}_PerBaseCoverage.txt
else
  echo -n "Scenario not supported ... please check values"
  exit
fi

:
