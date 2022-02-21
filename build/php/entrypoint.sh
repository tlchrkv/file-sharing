#!/usr/bin/env bash

composer install --no-interaction --no-ansi --optimize-autoloader --apcu-autoloader
rm -rf ~/.composer/cache/*
cd /opt/app
./vendor/bin/phalcon migration run
php-fpm
