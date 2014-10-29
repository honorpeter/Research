################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
zynq-fsbl-vanilla1.elf.size \


# All Target
all: zynq-fsbl-vanilla1.elf secondary-outputs

# Tool invocations
zynq-fsbl-vanilla1.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM gcc linker'
	arm-xilinx-eabi-gcc -L"/home/jared/Research/os/zynq-fsbl-vanilla/zynq-fsbl-vanilla1/src" -Wl,-T -Wl,../src/lscript.ld -L../../zynq-fsbl-vanilla1_bsp/ps7_cortexa9_0/lib -o "zynq-fsbl-vanilla1.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

zynq-fsbl-vanilla1.elf.size: zynq-fsbl-vanilla1.elf
	@echo 'Invoking: ARM Print Size'
	arm-xilinx-eabi-size zynq-fsbl-vanilla1.elf  |tee "zynq-fsbl-vanilla1.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES)$(ELFSIZE)$(S_UPPER_DEPS) zynq-fsbl-vanilla1.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
