################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.1/api/api_lib.c \
../lwip-1.4.1/api/api_msg.c \
../lwip-1.4.1/api/err.c \
../lwip-1.4.1/api/netbuf.c \
../lwip-1.4.1/api/netdb.c \
../lwip-1.4.1/api/netifapi.c \
../lwip-1.4.1/api/sockets.c \
../lwip-1.4.1/api/tcpip.c 

OBJS += \
./lwip-1.4.1/api/api_lib.o \
./lwip-1.4.1/api/api_msg.o \
./lwip-1.4.1/api/err.o \
./lwip-1.4.1/api/netbuf.o \
./lwip-1.4.1/api/netdb.o \
./lwip-1.4.1/api/netifapi.o \
./lwip-1.4.1/api/sockets.o \
./lwip-1.4.1/api/tcpip.o 

C_DEPS += \
./lwip-1.4.1/api/api_lib.d \
./lwip-1.4.1/api/api_msg.d \
./lwip-1.4.1/api/err.d \
./lwip-1.4.1/api/netbuf.d \
./lwip-1.4.1/api/netdb.d \
./lwip-1.4.1/api/netifapi.d \
./lwip-1.4.1/api/sockets.d \
./lwip-1.4.1/api/tcpip.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.1/api/%.o: ../lwip-1.4.1/api/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O3 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g -DNET_USE_DHCP -DLWIP_PROVIDE_ERRNO -DLWIP_COMPAT_MUTEX -DMICROSEMI_STDIO_THRU_MMUART1 -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3\GNU" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS\startup_gcc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\CoreTSE" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config\sys_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\port\FreeRTOS\M2SXXX" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC\ARM_CM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include\ipv4" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_gpio" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_hpdma" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_nvm" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_rtc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_spi" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_sys_services" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_timer" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_uart" -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


