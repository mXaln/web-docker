#!/bin/sh

[[ $APP_TYPE == "local" ]] && /scripts/hosts.sh

yarn --cwd v-mast.mvc/Nodejs install

export NODE_EXTRA_CA_CERTS=/etc/nginx/ssl/ca.homestead.homestead.crt && \
       pm2 start v-mast.mvc/Nodejs/server.js && \
       pm2 start v-mast.mvc/Nodejs/mailer.js

pm2 logs
