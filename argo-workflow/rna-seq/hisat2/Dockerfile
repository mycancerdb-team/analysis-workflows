FROM mgibio/rnaseq:1.0.0

ADD convert_fg.sh /root/convert_fg.sh
ADD run_step.sh /root/run_step.sh
WORKDIR /root

ENTRYPOINT [ "run_step.sh" ]
