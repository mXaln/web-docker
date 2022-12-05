#!/bin/bash

sudo -u www-data php composer.phar update
php-fpm
