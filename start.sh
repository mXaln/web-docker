#!/bin/bash

service redis-server start

pm2 start v-mast.mvc/Nodejs/server.js

/docker-entrypoint.sh

nginx -g "daemon off;"
