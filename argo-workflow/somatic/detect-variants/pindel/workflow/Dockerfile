FROM mgibio/cle:v1.4.2
#docker.cancerdb.io/mgbio-workflow/pindel:1.4.2

RUN apt update && apt install parallel -y

ADD exec_step.sh /root/exec_step.sh
ADD cat-out.sh /root/cat-out.sh
ADD run_step.pl /root/run_step.pl
