#!/bin/bash

git clone https://bitbucket.org/vmastteam/v-mast.mvc.git ./htdocs/v-mast.mvc

git clone https://bitbucket.org/vmastteam/v-raft.mvc.git ./htdocs/v-raft.mvc

docker-compose up --build