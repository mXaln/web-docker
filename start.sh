#!/bin/bash

service redis-server start

export NODE_EXTRA_CA_CERTS=/etc/nginx/ssl/ca.homestead.homestead.crt && pm2 start v-mast.mvc/Nodejs/server.js && pm2 start v-mast.mvc/Nodejs/mailer.js

/docker-entrypoint.sh

nginx -g "daemon off;"
