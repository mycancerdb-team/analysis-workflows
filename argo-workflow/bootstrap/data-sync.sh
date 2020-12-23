#!/bin/bash

# $VAULT_ENDPOINT is an env var s3://vault000-mycancerdb
# $PATIENT_ID is an env var #MDB000
# $GENOMIC_PATH is an env var /genomic/us-east-2:ce8dfa06-3409-4d96-903f-d0d8204073bd/

OUTPUTDIR="/data"

date
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-exome/" "${OUTPUTDIR}/samples/tumor-exome/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/somatic-exome/" "${OUTPUTDIR}/samples/normal-exome/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cancer-rna/" "${OUTPUTDIR}/samples/cancer-rna/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
##batch-2
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cegat/P78376_5_S000038/" "${OUTPUTDIR}/samples/tumor-exome-2/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
aws s3 cp "$VAULT_ENDPOINT/$GENOMIC_PATH/cegat/P78376_4_S000038/" "${OUTPUTDIR}/samples/normal-exome-2/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
##batch-3
aws s3 cp "$VAULT_ENDPOINT/RFS-000/cancer-exome/" "${OUTPUTDIR}/samples/tumor-exome-3/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
aws s3 cp "$VAULT_ENDPOINT/RFS-000/somatic-exome/" "${OUTPUTDIR}/samples/normal-exome-3/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
aws s3 cp "$VAULT_ENDPOINT/RFS-000/cancer-rna/" "${OUTPUTDIR}/samples/cancer-rna-3/" --recursive --region us-east-2 --endpoint-url http://s3-accelerate.amazonaws.com
#General Folders
mkdir -p ${OUTPUTDIR}/output/{select_variants,hla,phasevcf,pvacseq/{temp,pvacseq_predictions,normalized,decom,readcount,final},mutect/{split-ints,sani,normalized,fpfilter,decom},final/{pvacseq/temp,mhc_1,mhc_2},strelka/{indels,snv,sani,normalized,fpfilter,decom,rename},varscan/{variants,indels,snv,sani,normalized,fpfilter,decom,rename},pindel/{split-beds,sani,normalized,fpfilter,decom},docm/{raw,decom},detect-variants/{decom,readcount,final},cnvkit,manta,logs,samples/{tumor-exome,normal-exome,cancer-rna,normal-exome-2,tumor-exome-2,tumor-exome-3,normal-exome-3,cancer-rna-3}}
#RNA Folders
mkdir -p ${OUTPUTDIR}/output/{rna_final,rna_trimmed_read,rna_hisat2_align/aligned_bam,rna_merged_bam,rna_index_bam}
#Normal Folders
mkdir -p ${OUTPUTDIR}/output/{normal_final/{haplotyper,germline-filter,optitemp},normal_bwa,normal_dups,normal_namesort,normal_bqsr}
#Cancer Folders
mkdir -p ${OUTPUTDIR}/output/{cancer_final,cancer_bwa,cancer_dups,cancer_namesort,cancer_bqsr}
#VEP needs special permissions
chmod -R 0777 ${OUTPUTDIR}/output/detect-variants/ ${OUTPUTDIR}/output/normal_final
date
:
