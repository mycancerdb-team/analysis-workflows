FROM python:3.7.4-slim-buster
#docker.cancerdb.io/mgbio-workflow/hla-extract-consensus:1.0.0

ADD run_step.sh /root/run_step.sh

ADD hla_consensus.py /root/hla_consensus.py

ENTRYPOINT [ "/root/run_step.sh" ]
