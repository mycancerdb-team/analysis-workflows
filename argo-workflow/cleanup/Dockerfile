FROM ubuntu:16.04

COPY ./data-cleanup.sh /data-cleanup.sh

RUN apt-get update && apt-get upgrade -y && apt-get install apt-utils iptables groff ca-certificates software-properties-common \
  less vim apt-transport-https curl wget unzip python3 python3-pip sudo zsh -y && \
  pip3 install awscli

ENTRYPOINT ["/data-cleanup.sh"]
