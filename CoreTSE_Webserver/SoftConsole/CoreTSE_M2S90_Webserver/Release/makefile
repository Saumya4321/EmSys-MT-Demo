################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include lwip-1.4.1/port/FreeRTOS/M2SXXX/subdir.mk
-include lwip-1.4.1/netif/ppp/subdir.mk
-include lwip-1.4.1/netif/subdir.mk
-include lwip-1.4.1/core/snmp/subdir.mk
-include lwip-1.4.1/core/ipv4/subdir.mk
-include lwip-1.4.1/core/subdir.mk
-include lwip-1.4.1/api/subdir.mk
-include hal/CortexM3/GNU/subdir.mk
-include hal/CortexM3/subdir.mk
-include drivers_config/sys_config/subdir.mk
-include drivers/mss_uart/subdir.mk
-include drivers/mss_sys_services/subdir.mk
-include drivers/mss_spi/subdir.mk
-include drivers/mss_rtc/subdir.mk
-include drivers/mss_nvm/subdir.mk
-include drivers/mss_hpdma/subdir.mk
-include drivers/mss_gpio/subdir.mk
-include drivers/CoreTSE/subdir.mk
-include WebServer/subdir.mk
-include FreeRTOS/portable/MemMang/subdir.mk
-include FreeRTOS/portable/GCC/ARM_CM3/subdir.mk
-include FreeRTOS/subdir.mk
-include CMSIS/startup_gcc/subdir.mk
-include CMSIS/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
SECONDARY_FLASH += \
CoreTSE_M2S90_Webserver.hex \

SECONDARY_SIZE += \
CoreTSE_M2S90_Webserver.siz \


# All Target
all: CoreTSE_M2S90_Webserver.elf secondary-outputs

# Tool invocations
CoreTSE_M2S90_Webserver.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: Cross ARM C Linker'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O3 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g -T "D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS\startup_gcc\production-smartfusion2-execute-in-place.ld" -Xlinker --gc-sections -Wl,-Map,"CoreTSE_M2S90_Webserver.map" --specs=nano.specs -o "CoreTSE_M2S90_Webserver.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

CoreTSE_M2S90_Webserver.hex: CoreTSE_M2S90_Webserver.elf
	@echo 'Invoking: Cross ARM GNU Create Flash Image'
	arm-none-eabi-objcopy -O ihex "CoreTSE_M2S90_Webserver.elf"  "CoreTSE_M2S90_Webserver.hex"
	@echo 'Finished building: $@'
	@echo ' '

CoreTSE_M2S90_Webserver.siz: CoreTSE_M2S90_Webserver.elf
	@echo 'Invoking: Cross ARM GNU Print Size'
	arm-none-eabi-size --format=berkeley "CoreTSE_M2S90_Webserver.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(SECONDARY_FLASH)$(SECONDARY_SIZE)$(ASM_DEPS)$(S_UPPER_DEPS)$(C_DEPS) CoreTSE_M2S90_Webserver.elf
	-@echo ' '

secondary-outputs: $(SECONDARY_FLASH) $(SECONDARY_SIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
