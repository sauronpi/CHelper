# include(FetchContent)
# FetchContent_Declare(
#   ftxui
#   GIT_REPOSITORY https://github.com/ArthurSonzogni/ftxui
#   GIT_TAG v6.1.9
# )
# # 下载并构建该库（会自动处理依赖和构建）
# FetchContent_MakeAvailable(ftxui)

# 创建可执行文件
add_executable(${TARGET} ${ALL_SOURCES})

# target_link_libraries(${TARGET} PRIVATE
#     # Chose a submodule
#     ftxui::component
#     ftxui::dom
#     ftxui::screen
# )
