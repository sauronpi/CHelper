##### Makefile ######

######################################
# Target
######################################

TARGET ?= HelloWorld
 
#DIRECTORY
BUILD_DIRECTORY = Build
OUTPUT_DIRECTORY = Output
SDK_DIRECTORY = SDK
LIB_DIRECTORY = Lib
LIBS = -L$(LIB_DIRECTORY)/libavutil -lavutil
PROJECT_DIRECTORY = Project

C_INCLUDES = 
C_SOURCES =

C_INCLUDES += \
-I $(SDK_DIRECTORY)\
-I $(LIB_DIRECTORY)\
-I $(LIB_DIRECTORY)/libavutil\

C_SOURCES += \
$(wildcard $(SDK_DIRECTORY)/*.c)

C_SOURCES += \
$(wildcard $(PROJECT_DIRECTORY)/$(TARGET)/*.c)

OBJECTS = $(addprefix $(BUILD_DIRECTORY)/,$(notdir $(C_SOURCES:.c=.o)))

# make 只在当前目录下寻找文件，源码目录排序后添加到 vpath 给 make 寻找文件
vpath %.c $(sort $(dir $(C_SOURCES)))

#######################################
# Compiler
#######################################
COMPILER ?=gcc
COMPILER_OPTION = $(C_INCLUDES)

$(TARGET): $(OBJECTS) $(OUTPUT_DIRECTORY)
	@echo "$(COMPILER) $(OBJECTS) -o $(OUTPUT_DIRECTORY)/$(TARGET) $(LIBS)"
	@$(COMPILER) $(OBJECTS) -o $(OUTPUT_DIRECTORY)/$(TARGET) $(LIBS)

$(BUILD_DIRECTORY)/%.o: %.c $(BUILD_DIRECTORY)
	@echo "$(COMPILER) $(COMPILER_OPTION) -c $< -o $@"
	@$(COMPILER) $(COMPILER_OPTION) -c $< -o $@

$(BUILD_DIRECTORY):
	@echo "mkdir $@"
	@mkdir $@

$(OUTPUT_DIRECTORY):
	@echo "mkdir $@"
	@mkdir $@

.PHONY: clean
clean:
	-rm -rf $(BUILD_DIRECTORY) 

.PHONY: cleanall
cleanall:
	-rm -rf $(BUILD_DIRECTORY) $(OUTPUT_DIRECTORY)

.PHONY: info
info:
	@echo TARGET $(TARGET)
	@echo OBJECTS $(OBJECTS)
	@echo C_SOURCES $(C_SOURCES:.c=.o)
	@echo C_SOURCES $(dir $(C_SOURCES))
	@echo C_SOURCES $(sort $(dir $(C_SOURCES)))