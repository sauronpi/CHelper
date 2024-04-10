#!/bin/sh
MAKE_OPTION=-j

make clean

#
# TARGET
#
# TARGET=HelloWorld
TARGET=Random
# TARGET=Test

make $MAKE_OPTION TARGET=$TARGET
echo "Run $TARGET"
./Output/$TARGET