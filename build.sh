#!/bin/sh
COMPILER=clang
MAKE_OPTION=-j

make clean

#
# TARGET
#
# TARGET=HelloWorld
TARGET=Random
# TARGET=Test

make COMPILER=$COMPILER $MAKE_OPTION TARGET=$TARGET
echo "Run $TARGET"
./Output/$TARGET