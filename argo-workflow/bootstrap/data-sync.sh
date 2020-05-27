#!/bin/bash

# $VAULT_ENDPOINT is an env var s3://vault000-mycancerdb
# $PATIENT_ID is an env var #MDB000
# $GENOMIC_PATH is an env var /genomic/us-east-2:ce8dfa06-3409-4d96-903f-d0d8204073bd/

OUTPUTDIR="/data"

date
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-exome/" "${OUTPUTDIR}/samples/cancer-exome/" --recursive
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/somatic-exome/" "${OUTPUTDIR}/samples/somatic-exome/" --recursive
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-rna/" "${OUTPUTDIR}/samples/cancer-rna/" --recursive
#General Folders
mkdir -p ${OUTPUTDIR}/output/{select_variants,mutect/split-ints,final,strelka}
#RNA Folders
mkdir -p ${OUTPUTDIR}/output/{rna_final,rna_trimmed_read,rna_hisat2_align/aligned_bam,rna_merged_bam,rna_index_bam}
#Normal Folders
mkdir -p ${OUTPUTDIR}/output/{normal_final,normal-align,normal_bwa,normal_dups,normal_namesort,normal_bqsr}
#Cancer Folders
mkdir -p ${OUTPUTDIR}/output/{cancer_final,cancer-align,cancer_bwa,cancer_dups,cancer_namesort,cancer_bqsr}
date
:
