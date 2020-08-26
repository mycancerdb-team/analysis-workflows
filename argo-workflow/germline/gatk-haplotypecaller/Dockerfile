FROM mgibio/gatk-cwl:3.5.0
## docker.cancerdb.io/mgbio-workflow/gatk-haplotype:3.5.0

RUN apt update && apt install parallel -y

ADD run_step.sh /root/run_step.sh

ENTRYPOINT [ "/root/run_step.sh" ]
