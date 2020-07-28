FROM ubuntu:latest
#docker.cancerdb.io/mcdb-bots/jsonify-list:latest

ADD run_step.sh /root/run_step.sh

RUN apt update && apt upgrade -y && apt install jq vim -y

ENTRYPOINT [ "/root/run_step.sh" ]
