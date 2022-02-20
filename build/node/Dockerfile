FROM node:17

RUN apt-get update

WORKDIR /opt/app

COPY ./build/node/entrypoint.sh /home/app/entrypoint.sh

CMD /home/app/entrypoint.sh
