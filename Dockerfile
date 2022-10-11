FROM node:16
MAINTAINER Dustin McIntire <dustin.mcintire@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    git
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/dustinmcintire/virtual-smart-home.git
RUN git checkout --track origin/sandbox
WORKDIR /data/virtual-smart-home
RUN npm install
RUN npm install -g serverless

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN useradd -m vsh

# Force update of cloudformation from eu-west-1
COPY env.sh /.env
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh", "virtual-smart-home"]

CMD ["serverless deploy"]
