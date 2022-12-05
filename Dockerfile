FROM nginx:1.21.1

RUN apt-get update && apt-get install -y nano procps

WORKDIR /var/www/html

COPY ./start.sh /start.sh
ENTRYPOINT ["/start.sh"]
