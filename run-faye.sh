#!/bin/sh
cd $(dirname $0)
IM_FAYE=true rackup -p 9292 -E production
