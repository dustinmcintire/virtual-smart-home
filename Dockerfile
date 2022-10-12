FROM node:16
MAINTAINER Dustin McIntire <dustin.mcintire@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    git
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/dustinmcintire/virtual-smart-home.git
WORKDIR /data/virtual-smart-home
RUN git checkout --track origin/sandbox
RUN npm install
RUN npm install -g serverless

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN useradd -m vsh
RUN chown -R vsh /data/virtual-smart-home
USER vsh

# Force update of cloudformation from eu-west-1
COPY env.sh /data/virtual-smart-home/.env
#COPY docker-entrypoint.sh /
#ENTRYPOINT ["/docker-entrypoint.sh", "virtual-smart-home"]

CMD ["/bin/bash", "-c", "export $(grep -v '^#' .env | xargs) && serverless deploy"]
