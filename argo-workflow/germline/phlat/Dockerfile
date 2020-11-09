FROM machalen/bowtie2
#docker.cancerdb.io/mgbio-workflow/hla-phlat:1.0.0
WORKDIR /opt/

ADD run_step.sh /root/run_step.sh

RUN apt-get update -y && apt-get install -y --no-install-recommends \
  python-pip build-essential python-all-dev python-setuptools python-wheel zlib1g-dev && \
  pip install pysam==0.8.4 && pip install gdown && gdown -O phlat-release-1.1_Ubuntu.tar.gz --id 0ByHcYNU3A9ADVnNMR2FYd1M0bGs && \
  gunzip phlat-release-1.1_Ubuntu.tar.gz && tar -xvf phlat-release-1.1_Ubuntu.tar && \
  rm -f phlat-release-1.1_Ubuntu.tar && mkdir -p /usr/picard && gdown -O /usr/picard/picard.jar --id 1fmwMmO5I6MRLna7uhgLcgPInLE4In66C

ENTRYPOINT [ "/root/run_step.sh" ]
