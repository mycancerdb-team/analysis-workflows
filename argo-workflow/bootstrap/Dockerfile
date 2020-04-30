FROM ubuntu:16.04

ADD data-sync.sh /data-sync.sh

RUN apt update && apt upgrade -y && apt install less vim apt-transport-https curl wget unzip python python-pip sudo zsh git -y && \
  pip install awscli

ENTRYPOINT ["/data-sync.sh"]
