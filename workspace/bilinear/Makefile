# Project: Image
# Author: Jared Bold

CC=gcc
CFLAGS=-c -Wall

# Directory Structure
SRC_DIR=src
BUILD_DIR=build
OUTPUT_DIR=output
INCLUDE_DIR=include

# Set the target executable
TARGET_FILE=bilinear
# Add the src files
SRC_FILES=main.c image.c bilinear.c

OBJ_FILES=$(SRC_FILES:.c=.o)
DEP_FILES=$(OBJ_FILES:.o=.d)

SRCS=$(foreach SRC, $(SRC_FILES), $(SRC_DIR)/$(SRC))
OBJS=$(foreach OBJ, $(OBJ_FILES), $(BUILD_DIR)/$(OBJ))
DEPS=$(foreach DEP, $(DEP_FILES), $(BUILD_DIR)/$(DEP))
TARGET=$(OUTPUT_DIR)/$(TARGET_FILE)
INCLUDES=-I$(INCLUDE_DIR)
LDIRS=
LIBS=-ltiff -lm

# PHONY labels
.PHONY: all
.PHONY: clean
.PHONY: release
.PHONY: debug

all:$(TARGET)

release: CFLAGS += -O3
release: all

debug: CFLAGS += -O0 -ggdb -DDEBUG
debug: all

$(TARGET): $(OBJS)
	@echo 'Buildig target: $@'
	@echo 'Invoking $(CC) Linker'
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(LDIRS) -o $(TARGET) $(OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

$(OBJS): $(SRCS)
	$(eval file=$(subst $(BUILD_DIR),$(SRC_DIR),$@))
	$(eval file2=$(file:.o=.c))
	@echo 'Building file: $(file2)'
	@echo 'Invoking $(CC)'
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o $@ "$(file2)"
	@echo 'Finished building: $(file2)'
	@echo ' '

clean:
	@echo $(SRCS)
	@echo $(OBJS)
	@echo $(DEPS)
	rm -rf output
	rm -rf build
