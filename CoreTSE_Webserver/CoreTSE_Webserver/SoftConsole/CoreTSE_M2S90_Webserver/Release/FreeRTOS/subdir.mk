################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../FreeRTOS/croutine.c \
../FreeRTOS/list.c \
../FreeRTOS/queue.c \
../FreeRTOS/tasks.c \
../FreeRTOS/timers.c 

OBJS += \
./FreeRTOS/croutine.o \
./FreeRTOS/list.o \
./FreeRTOS/queue.o \
./FreeRTOS/tasks.o \
./FreeRTOS/timers.o 

C_DEPS += \
./FreeRTOS/croutine.d \
./FreeRTOS/list.d \
./FreeRTOS/queue.d \
./FreeRTOS/tasks.d \
./FreeRTOS/timers.d 


# Each subdirectory must supply rules for building sources it contributes
FreeRTOS/%.o: ../FreeRTOS/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O3 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g -DNET_USE_DHCP -DLWIP_PROVIDE_ERRNO -DLWIP_COMPAT_MUTEX -DMICROSEMI_STDIO_THRU_MMUART1 -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3\GNU" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS\startup_gcc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\CoreTSE" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config\sys_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\port\FreeRTOS\M2SXXX" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC\ARM_CM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include\ipv4" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_gpio" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_hpdma" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_nvm" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_rtc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_spi" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_sys_services" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_timer" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_uart" -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


