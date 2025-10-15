#!/bin/bash
set -euo pipefail

# TARGET="HelloWorld"
TARGET="SizeOfTest"
echo "TARGET: $TARGET"

BUILD_DIRECTORY="Build"
CMAKE_GENERATOR="Unix Makefiles"
echo "BUILD_DIRECTORY: $BUILD_DIRECTORY"
echo "CMAKE_GENERATOR: $CMAKE_GENERATOR"

# 创建构建目录（如果不存在）
if [ ! -d "$BUILD_DIRECTORY" ]; then
  echo "Create build directory: $BUILD_DIRECTORY"
  mkdir -p "$BUILD_DIRECTORY"
  if [ $? -eq 0 ]; then
    echo "Create build directory succeeded"
  else
    echo "Create build directory failed"
    exit 1
  fi
fi

echo "Enter build directory: $BUILD_DIRECTORY"
cd "$BUILD_DIRECTORY" || {
  echo "Failed to enter build directory"
  exit 1
}

# 检查cmake是否安装
if ! command -v cmake &>/dev/null; then
  echo "cmake not found"
  cd ..
  exit 1
fi

# 检查make是否安装
if ! command -v make &>/dev/null; then
  echo "make not found"
  cd ..
  exit 1
fi

# 执行CMake配置和构建
cmake .. -G "$CMAKE_GENERATOR" -DTARGET="$TARGET"
if [ $? -ne 0 ]; then
  echo "CMake configuration failed"
  cd ..
  exit 1
fi

echo "Copy compile_commands.json to ../"
cp compile_commands.json ../

make -j
if [ $? -ne 0 ]; then
  echo "Build failed"
  cd ..
  exit 1
fi

cd ..

echo "Run $TARGET"
Output/"$TARGET"

exit 0
