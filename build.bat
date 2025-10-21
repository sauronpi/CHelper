@echo off
setlocal enabledelayedexpansion

set PROJECT_LANGUAGE="C"
set TARGET=HelloWorld
REM set TARGET=SizeOfTest
REM set PROJECT_LANGUAGE="CXX"
REM set TARGET=FTXUI

echo TARGET: %TARGET% 
echo PROJECT_LANGUAGE %CXX%

set BUILD_DIRECTORY=Build
set CMAKE_GENERATOR="MinGW Makefiles"
echo BUILD_DIRECTORY: %BUILD_DIRECTORY%
echo CMAKE_GENERATOR: %CMAKE_GENERATOR%

REM 创建构建目录（如果不存在）
if not exist %BUILD_DIRECTORY% (
    echo Create build directory: %BUILD_DIRECTORY%
    mkdir %BUILD_DIRECTORY%
    if %errorlevel% equ 0 (  :: 修正判断逻辑，0表示成功
        echo Create build directory succeeded
    ) else (
        echo Create build directory failed
        exit /b 1
    )
)
echo Enter build directory: %BUILD_DIRECTORY%
cd %BUILD_DIRECTORY% || (  :: 增加目录切换失败的判断
    echo Failed to enter build directory
    exit /b 1
)

REM 检查cmake是否安装
cmake --version >nul 2>&1
if %errorlevel% neq 0 (
    echo cmake not found
    cd ..
    exit /b 1
)
REM 检查make是否安装
mingw32-make --version >nul 2>&1
if %errorlevel% neq 0 (
    echo mingw32-make not found
    cd ..
    exit /b 1
)

REM 执行cmake配置和构建
cmake .. -G %CMAKE_GENERATOR% -DTARGET=%TARGET% -DPROJECT_LANGUAGE=%PROJECT_LANGUAGE%
if %errorlevel% neq 0 (
    echo CMake configuration failed
    cd ..
    exit /b 1
)

echo copy compile_commands.json to ../
copy compile_commands.json ..\

mingw32-make -j
if %errorlevel% neq 0 (
    echo Build failed
    cd ..
    exit /b 1
)

cd ..

echo Run Output\%TARGET%
Output\%TARGET%

endlocal
exit /b 0
