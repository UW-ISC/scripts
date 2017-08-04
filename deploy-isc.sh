#!/usr/bin/env bash

source ./envvars.sh

cd $WORDPRESS_PATH
git checkout $TRACKING_BRANCH
git pull
git checkout -b `date "+%Y-%m-%d-%H-%M"` $TRACKING_BRANCH
echo "Current branch is $TRACKING_BRANCH at: "
git symbolic-ref HEAD

cd $ISC_THEME_PATH
git checkout $TRACKING_BRANCH
git pull
git checkout -b `date "+%Y-%m-%d-%H-%M"` $TRACKING_BRANCH
echo "Current branch is $TRACKING_BRANCH at: "
git symbolic-ref HEAD
