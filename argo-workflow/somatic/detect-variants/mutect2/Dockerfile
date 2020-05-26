FROM broadinstitute/gatk:4.1.2.0
#docker.cancerdb.io/mgbio-workflow/mutect2:4.1.2.0
ADD mutect2-wrkflw.sh /root/mutect2-wrkflw.sh
ADD run_step.sh /root/mutect2.sh

RUN apt-get update && apt install parallel -y

WORKDIR /root
