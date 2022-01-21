FROM ubuntu
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:nilarimogard/webupd8
RUN apt-get update
RUN apt-get install -y grive
WORKDIR /home/grive

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]]
