################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lwip-1.4.1/core/ipv4/autoip.c \
../lwip-1.4.1/core/ipv4/icmp.c \
../lwip-1.4.1/core/ipv4/igmp.c \
../lwip-1.4.1/core/ipv4/inet.c \
../lwip-1.4.1/core/ipv4/inet_chksum.c \
../lwip-1.4.1/core/ipv4/ip.c \
../lwip-1.4.1/core/ipv4/ip_addr.c \
../lwip-1.4.1/core/ipv4/ip_frag.c 

OBJS += \
./lwip-1.4.1/core/ipv4/autoip.o \
./lwip-1.4.1/core/ipv4/icmp.o \
./lwip-1.4.1/core/ipv4/igmp.o \
./lwip-1.4.1/core/ipv4/inet.o \
./lwip-1.4.1/core/ipv4/inet_chksum.o \
./lwip-1.4.1/core/ipv4/ip.o \
./lwip-1.4.1/core/ipv4/ip_addr.o \
./lwip-1.4.1/core/ipv4/ip_frag.o 

C_DEPS += \
./lwip-1.4.1/core/ipv4/autoip.d \
./lwip-1.4.1/core/ipv4/icmp.d \
./lwip-1.4.1/core/ipv4/igmp.d \
./lwip-1.4.1/core/ipv4/inet.d \
./lwip-1.4.1/core/ipv4/inet_chksum.d \
./lwip-1.4.1/core/ipv4/ip.d \
./lwip-1.4.1/core/ipv4/ip_addr.d \
./lwip-1.4.1/core/ipv4/ip_frag.d 


# Each subdirectory must supply rules for building sources it contributes
lwip-1.4.1/core/ipv4/%.o: ../lwip-1.4.1/core/ipv4/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O3 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g -DNET_USE_DHCP -DLWIP_PROVIDE_ERRNO -DLWIP_COMPAT_MUTEX -DMICROSEMI_STDIO_THRU_MMUART1 -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\hal\CortexM3\GNU" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\CMSIS\startup_gcc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\CoreTSE" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers_config\sys_config" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\port\FreeRTOS\M2SXXX" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\FreeRTOS\portable\GCC\ARM_CM3" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\lwip-1.4.1\include\ipv4" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_gpio" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_hpdma" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_nvm" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_rtc" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_spi" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_sys_services" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_timer" -I"D:\CASES\coretse\CoreTSE_Webserver\SoftConsole\CoreTSE_M2S90_Webserver\drivers\mss_uart" -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


