################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_clean.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_init.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_timer_hw.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_cg.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_hist.c 

S_UPPER_SRCS += \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/dummy.S \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_arm.S \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_mb.S \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_ppc.S 

OBJS += \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_clean.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_init.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_timer_hw.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/dummy.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_cg.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_hist.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_arm.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_mb.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_ppc.o 

C_DEPS += \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_clean.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_init.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/_profile_timer_hw.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_cg.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_hist.d 

S_UPPER_DEPS += \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/dummy.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_arm.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_mb.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/profile_mcount_ppc.d 


# Each subdirectory must supply rules for building sources it contributes
fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/%.o: ../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I"/home/jared/Research/vivado_workspace/axi_loopback/vivado/project_1.sdk/ZC702_hw_platform" -c -fmessage-length=0 -I/home/jared/Research/os/zynq-fsbl-vanilla/fsbl_vanilla_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/%.o: ../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/standalone_v4_1/src/profile/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I"/home/jared/Research/vivado_workspace/axi_loopback/vivado/project_1.sdk/ZC702_hw_platform" -c -fmessage-length=0 -I/home/jared/Research/os/zynq-fsbl-vanilla/fsbl_vanilla_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


