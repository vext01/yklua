#!/bin/sh

set -e

MODE=release

echo "Yk CFLAGS":
yk-config ${MODE} --cflags

echo "Yk LDFLAGS":
yk-config ${MODE} --ldflags

make clean && make YK_BUILD_TYPE=release

cd tests

LUA=../src/lua
# XXX we should repeat, say, 5 or 10 times to try to rule out non-deterministic
# crashes.
for serialise in 0 1; do
    for test in api bwcoercion closure code coroutine events \
        gengc pm tpack tracegc utf8 vararg; do
        echo "### YKD_SERIALISE_COMPILATION=$serialise $test.lua ###"
        YKD_SERIALISE_COMPILATION=$serialise ${LUA} ${test}.lua
    done
done
