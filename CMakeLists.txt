cmake_minimum_required(VERSION 3.10)

# 启用compile_commands.json生成
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 设置目标名称，默认为HelloWorld
set(TARGET "HelloWorld" CACHE STRING "Target executable name")

# 目录设置
set(BUILD_DIRECTORY "Build")
set(OUTPUT_DIRECTORY "../Output")
set(ARCHIVE_DIRECTORY "Archive")
set(SDK_DIRECTORY "SDK")
set(LIBS_DIRECTORY "Libs")
set(PROJECT_DIRECTORY "Project")

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARCHIVE_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIRECTORY})

# 创建项目
project(${TARGET} C)

# 设置C标准
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# 收集源文件
file(GLOB SDK_SOURCES "${SDK_DIRECTORY}/*.c")
file(GLOB PROJECT_SOURCES "${PROJECT_DIRECTORY}/${TARGET}/*.c")
set(ALL_SOURCES ${SDK_SOURCES} ${PROJECT_SOURCES})

# 设置包含目录
include_directories(
    ${SDK_DIRECTORY}
    ${LIBS_DIRECTORY}
    "${PROJECT_DIRECTORY}/${TARGET}"
)

# 设置库目录和链接库
# link_directories("${LIBS_DIRECTORY}/libavutil")
# link_libraries(avutil)

# 创建可执行文件
add_executable(${TARGET} ${ALL_SOURCES})

# 确保输出到指定目录
set_target_properties(${TARGET} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIRECTORY}
)

# 创建Build和Output目录（如果不存在）
file(MAKE_DIRECTORY ${BUILD_DIRECTORY} ${OUTPUT_DIRECTORY})

# 自定义清理目标
add_custom_target(cleanall
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BUILD_DIRECTORY}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${OUTPUT_DIRECTORY}
    COMMENT "Cleaning all build and output directories"
    DEPENDS clean
)

# 显示项目信息的目标
add_custom_target(info
    COMMAND ${CMAKE_COMMAND} -E echo "TARGET: ${TARGET}"
    COMMAND ${CMAKE_COMMAND} -E echo "SOURCE FILES: ${ALL_SOURCES}"
    COMMAND ${CMAKE_COMMAND} -E echo "INCLUDE DIRECTORIES: $<TARGET_PROPERTY:${TARGET},INCLUDE_DIRECTORIES>"
    COMMENT "Displaying project information"
)
