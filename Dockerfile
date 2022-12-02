FROM nginx:1.21.1

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && rm nodesource_setup.sh

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get remove yarn && apt-get update && apt-get install -y yarn

RUN apt-get update && apt-get install -y nodejs redis nano procps sendmail git
RUN yarn global add pm2

WORKDIR /var/www/html

COPY ./start.sh /start.sh
ENTRYPOINT ["/start.sh"]
