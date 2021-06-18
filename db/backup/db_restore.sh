#!/bin/bash

set -ex

DIR=/backup

echo -e "\e[93m\e[4mEnter backup folder name (Ex. 2017-12-26_16_50_36)\e[0m"
read backup

if [ ! -d $DIR/$backup ]; then
	echo -e "\e[91mThere is no backup with this name\e[0m"
	exit
fi

if [ ! -d $DIR/$backup/base ]; then
	echo -e "\e[91mThere is no base folder in this backup\e[0m"
	exit
fi

echo -e "\e[93m\e[4mEnter an hour to restore to (From 1 to 24 or 0 for base restore)\e[0m"
read hour

if [ ! -d $DIR/$backup/incr$hour ] && [ "$hour" -gt 0 ]; then
	echo -e "\e[91mThere is no backup for this hour\e[0m"
	exit
fi

trap 'echo "removing /tmp/$backup"; rm -rf /tmp/$backup' INT TERM EXIT

# Copy backup to Tmp folder
cp -r $DIR/$backup /tmp/$backup

# prepare base
echo -e "\e[103m\e[91mPreparing base backup...\e[0m"
sleep 1
xtrabackup --prepare --apply-log-only --target-dir=/tmp/$backup/base

#prepare increment
if [ "$hour" -gt 0 ]; then
	for ((i = 1; i <= hour; i++))
	do 
		echo -e "\e[103m\e[91mPreparing increment backup #$i...\e[0m"
		sleep 1
		xtrabackup --prepare --apply-log-only --target-dir=/tmp/$backup/base \
			--incremental-dir=/tmp/$backup/incr$i
	done
fi

rm -rf /var/lib/mysql/*
echo -e "\e[103m\e[91mCopying backup data to mysql folder...\e[0m"
xtrabackup --copy-back --target-dir=/tmp/$backup/base --datadir=/var/lib/mysql
chown -R mysql:mysql /var/lib/mysql/
service mysql restart
