#!/bin/sh
cd $(dirname $0)
rackup faye.ru -E production
