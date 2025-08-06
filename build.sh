#!/bin/bash
DetectArchitecture() {
    # 获取原始架构信息
    arch=$(uname -m)

    # 架构归一化处理
    case "$arch" in
        x86_64 | x64 | amd64)
            NORMALIZED_ARCH="amd64"
            ;;
        aarch64 | arm64)
            NORMALIZED_ARCH="arm64"
            ;;
        armv7l | armv6l | arm)
            NORMALIZED_ARCH="arm"
            ;;
        i386 | i686)
            NORMALIZED_ARCH="386"
            ;;
        *)
            NORMALIZED_ARCH="$ARCH"
            ;;
    esac
    echo "$NORMALIZED_ARCH"
}

DetectOperatingSystem() {
    case "$(uname -s)" in
        Linux*)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                echo "Linux ($NAME)"
            else
                echo "Linux"
            fi
            ;;
        Darwin*)
            echo "macOS"
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            echo "Windows"
            ;;
        *)
            echo "Unknown OS"
            ;;
    esac
}

arch=$(DetectArchitecture)
os=$(DetectOperatingSystem)
echo "Architecture: $arch"
echo "Operating System: $operatingSystem"
COMPILER=clang
MAKE_OPTION=-j
PROJECT=${1-"FFmpeg"}
# PROJECT=FFmpeg
# PROJECT=HelloWorld
# PROJECT=Random
# PROJECT=Test
echo "make clean"
make clean

make $MAKE_OPTION TARGET=$PROJECT COMPILER=$COMPILER ARCH=$arch OS="$os"
echo "Run $PROJECT"
./Output/$PROJECT
