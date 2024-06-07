#!/bin/sh

set -e

if [ -z "${YKLUA_HOME}" ]; then
    echo "YKLUA_HOME environment variable is not defined."; 
    exit 1
fi

if [ -z "${YK_BUILD_TYPE}" ]; then
    echo "YK_BUILD_TYPE environment variable is not defined."; 
    exit 1
fi

if ! command -v yk-config 2>&1 ; then
    echo "yk-config is not found."
    echo "See installation instructions: https://github.com/marxin/cvise."
    exit 1
fi

# Rebuild with the reduced onelua.c in-place.
#
# Note that it's not enough to just copy onelua.c and `Makefile` in. The whole
# `src` dir is needed.
cp -r "${YKLUA_HOME}/creduce/src" ./
cp onelua.c src/
cd ./src

make onelua

# oracle
./onelua -e "print('hello world')" | grep "hello world"
