FROM node:10-slim
MAINTAINER Giorgio Regni <gr@scality.com>

ENV NO_PROXY localhost,127.0.0.1
ENV no_proxy localhost,127.0.0.1

EXPOSE 8000

COPY ./package.json /usr/src/app/

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y jq python git build-essential --no-install-recommends \
    && npm install --production \
    && rm -rf /var/lib/apt/lists/* \
    && npm cache clear --force \
    && rm -rf ~/.node-gyp \
    && rm -rf /tmp/npm-*

COPY . /usr/src/app

VOLUME ["/usr/src/app/localData","/usr/src/app/localMetadata"]

ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]

CMD [ "npm", "start" ]
