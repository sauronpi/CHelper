##### Makefile ######

######################################
# Target
######################################

TARGET ?= HelloWorld
ARCH =
OS = 
 
#DIRECTORY
BUILD_DIRECTORY := Build
OUTPUT_DIRECTORY := Output
SDK_DIRECTORY := SDK
LIBS_DIRECTORY := Libs
PROJECT_DIRECTORY := Project

C_INCLUDES = 
C_SOURCES =

# SDK files
C_INCLUDES += \
-I $(SDK_DIRECTORY)

C_SOURCES += \
$(wildcard $(SDK_DIRECTORY)/*.c)

# Libs files
C_INCLUDES += \
-I $(LIBS_DIRECTORY)

LIBS := -L$(LIBS_DIRECTORY)/libavutil -lavutil

# Project files
C_INCLUDES += \
-I $(PROJECT_DIRECTORY)/$(TARGET)

C_SOURCES += \
$(wildcard $(PROJECT_DIRECTORY)/$(TARGET)/*.c)

# Objects
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