################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/xilffs_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/xadcps_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/usbps_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/uartps_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/ttcps_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/sdps_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/scuwdt_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/scutimer_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/scugic_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/qspips_v3_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/iicps_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/gpiops_v2_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/dmaps_v2_0/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/devcfg_v3_1/src/subdir.mk
-include fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/canps_v2_0/src/subdir.mk
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
fsbl_vanilla.elf.size \


# All Target
all: fsbl_vanilla.elf secondary-outputs

# Tool invocations
fsbl_vanilla.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM gcc linker'
	arm-xilinx-eabi-gcc -L"/home/jared/Research/os/zynq-fsbl-vanilla/src" -Wl,-T -Wl,../src/lscript.ld -L/home/jared/Research/os/zynq-fsbl-vanilla/fsbl_vanilla_bsp/ps7_cortexa9_0/lib -o "fsbl_vanilla.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

fsbl_vanilla.elf.size: fsbl_vanilla.elf
	@echo 'Invoking: ARM Print Size'
	arm-xilinx-eabi-size fsbl_vanilla.elf  |tee "fsbl_vanilla.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES)$(ELFSIZE)$(S_UPPER_DEPS) fsbl_vanilla.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
