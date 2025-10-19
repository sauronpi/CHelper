cmake_minimum_required(VERSION 3.10)

# 设置C标准
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 启用compile_commands.json生成
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 设置默认语言为 C，通过 -DPROJECT_LANGUAGE=C 覆盖
set(PROJECT_LANGUAGE "C" CACHE STRING "Specify the project language (C or CXX)")

# 设置目标名称，默认为HelloWorld，通过 -DPROJECT_LANGUAGE=C 覆盖
set(TARGET "HelloWorld" CACHE STRING "Target executable name")

# 目录设置
set(BUILD_DIRECTORY "Build")
set(OUTPUT_DIRECTORY "Output")
set(ARCHIVE_DIRECTORY "Archive")
set(SDK_DIRECTORY "SDK")
set(LIBS_DIRECTORY "Libs")
set(PROJECT_DIRECTORY "Project")

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARCHIVE_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIRECTORY})

project(${TARGET} ${PROJECT_LANGUAGE})

#收集源文件 - 分别收集C和C++文件然后合并
file(GLOB SDK_C_SOURCES "${SDK_DIRECTORY}/*.c")
file(GLOB SDK_CPP_SOURCES "${SDK_DIRECTORY}/*.cpp")
file(GLOB PROJECT_C_SOURCES "${PROJECT_DIRECTORY}/${TARGET}/*.c")
file(GLOB PROJECT_CPP_SOURCES "${PROJECT_DIRECTORY}/${TARGET}/*.cpp")

# 合并所有源文件
set(ALL_SOURCES
    ${SDK_C_SOURCES}
    ${SDK_CPP_SOURCES}
    ${PROJECT_C_SOURCES}
    ${PROJECT_CPP_SOURCES}
)

# 调试信息：显示找到的源文件
message(STATUS "Found source files: ${ALL_SOURCES}")

# 检查是否有源文件
list(LENGTH ALL_SOURCES NUM_SOURCES)
if(NUM_SOURCES EQUAL 0)
  message(WARNING "No source files found! Check your directory structure.")
endif()

# 设置包含目录
include_directories(
    ${SDK_DIRECTORY}
    ${LIBS_DIRECTORY}
    "${PROJECT_DIRECTORY}/${TARGET}"
)

# 设置库目录和链接库
# link_directories("${LIBS_DIRECTORY}/libavutil")
# link_libraries(avutil)

# 根据目标添加对应的项目
add_subdirectory("${PROJECT_DIRECTORY}/${TARGET}")

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
# add_custom_target(info
#     COMMAND ${CMAKE_COMMAND} -E echo "TARGET: ${TARGET}"
#     COMMAND ${CMAKE_COMMAND} -E echo "SOURCE FILES: ${ALL_SOURCES}"
#     COMMAND ${CMAKE_COMMAND} -E echo "INCLUDE DIRECTORIES: $<TARGET_PROPERTY:${TARGET},INCLUDE_DIRECTORIES>"
#     COMMENT "Displaying project information"
# )
