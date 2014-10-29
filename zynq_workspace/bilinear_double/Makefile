# Project: Image
# Author: Jared Bold

CC=gcc
CFLAGS=-c -Wall

CC_ZYNQ=arm-xilinx-linux-gnueabi-gcc

# ARM locations
INCLUDE_ZYNQ=/home/jared/Research/libs/arm-linux/libtiff/tiff-4.0.3-build/include
LDIRS_ZYNQ=/home/jared/Research/libs/arm-linux/libtiff/tiff-4.0.3-build/lib
LDIRS_ZYNQ+=/home/jared/Research/zynq_workspace/axi_dma/output

# Directory Structure
SRC_DIR=src
BUILD_DIR=build
OUTPUT_DIR=output
INCLUDE_DIR=include

# Set the target executable
TARGET_FILE=bilinear_double
# Add the src files
SRC_FILES=main.c image.c bilinear_double.c benchmark.c hardware_bilinear_horz_double.c

OBJ_FILES=$(SRC_FILES:.c=.o)
DEP_FILES=$(OBJ_FILES:.o=.d)

SRCS=$(foreach SRC, $(SRC_FILES), $(SRC_DIR)/$(SRC))
OBJS=$(foreach OBJ, $(OBJ_FILES), $(BUILD_DIR)/$(OBJ))
DEPS=$(foreach DEP, $(DEP_FILES), $(BUILD_DIR)/$(DEP))
TARGET=$(OUTPUT_DIR)/$(TARGET_FILE)
INCLUDES=$(addprefix -I, $(INCLUDE_DIR))
LDIRS=-L./lib
LIBS=-ltiff -lm

# PHONY labels
.PHONY: all
.PHONY: clean
.PHONY: release
.PHONY: debug
.PHONY: zynq_release
.PHONY: zynq_debug
.PHONY: test

all:$(TARGET)

release: CFLAGS += -O3
release: all

debug: CFLAGS += -O0 -ggdb -DDEBUG
debug: all

zynq_release: CC=$(CC_ZYNQ)
zynq_release: CFLAGS=-DZYNQ
zynq_release: INCLUDES += $(addprefix -I, $(INCLUDE_ZYNQ))
zynq_release: LIBS += -laxi_dma
zynq_release: LDIRS += $(addprefix -L, $(LDIRS_ZYNQ))
zynq_release: release

zynq_debug: CC=$(CC_ZYNQ)
zynq_debug: CFLAGS=-DZYNQ
zynq_debug: INCLUDES += $(addprefix -I, $(INCLUDE_ZYNQ))
zynq_debug: LIBS += -laxi_dma
zynq_debug: LDIRS += $(addprefix -L, $(LDIRS_ZYNQ))
zynq_debug: debug


$(TARGET): $(OBJS)
	@echo 'Buildig target: $@'
	@echo 'Invoking $(CC) Linker'
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(LDIRS) -o $(TARGET) $(OBJS) $(LIBS) $(LIBS_STATIC)
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

test:
	./$(TARGET) ./data/Lena.tif
