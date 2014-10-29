################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_bdring.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_control.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_g.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_hw.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_intr.c \
../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_sinit.c 

OBJS += \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_bdring.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_control.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_g.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_hw.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_intr.o \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_sinit.o 

C_DEPS += \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_bdring.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_control.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_g.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_hw.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_intr.d \
./fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/xemacps_sinit.d 


# Each subdirectory must supply rules for building sources it contributes
fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/%.o: ../fsbl_vanilla_bsp/ps7_cortexa9_0/libsrc/emacps_v2_0/src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -I"/home/jared/Research/vivado_workspace/axi_loopback/vivado/project_1.sdk/ZC702_hw_platform" -c -fmessage-length=0 -I/home/jared/Research/os/zynq-fsbl-vanilla/fsbl_vanilla_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


