#!/bin/sh
make clean
COMPILER=clang
MAKE_OPTION=-j
PROJECT=${1-"HelloWorld"}

# Set the target
# TARGET=FFmpeg
# TARGET=HelloWorld
# TARGET=Random
# TARGET=Test

make $MAKE_OPTION TARGET=$PROJECT COMPILER=$COMPILER
echo "Run $PROJECT"
./Output/$PROJECT
