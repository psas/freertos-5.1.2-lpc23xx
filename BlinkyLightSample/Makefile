#	FreeRTOS.org V5.1.2 - Copyright (C) 2003-2009 Richard Barry.
#
#	This file is part of the FreeRTOS.org distribution.
#
#	FreeRTOS.org is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	FreeRTOS.org is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with FreeRTOS.org; if not, write to the Free Software
#	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#	A special exception to the GPL can be applied should you wish to distribute
#	a combined work that includes FreeRTOS.org, without being obliged to provide
#	the source code for any proprietary components.  See the licensing section 
#	of http://www.FreeRTOS.org for full details of how and when the exception
#	can be applied.
#
#	***************************************************************************
#	See http://www.FreeRTOS.org for documentation, latest information, license 
#	and contact details.  Please ensure to read the configuration and relevant 
#	port sections of the online documentation.
#	***************************************************************************


RTOS_SOURCE_DIR=../Source
DEMO_COMMON_DIR=../Common/Minimal
DEMO_INCLUDE_DIR=../Common/include
LPCUSB_COMMON_DIR=../Common/drivers/LPC/usb

CC=arm-elf-gcc
OBJCOPY=arm-elf-objcopy
CD = arm-elf-objdump
LDSCRIPT=lpc2368.ld

PROJECT_NAME=BlinkyLightSample

LINKER_FLAGS= -g3 -mthumb -nostartfiles -Xlinker -o$(PROJECT_NAME).elf -Xlinker -M -Xlinker -Map=$(PROJECT_NAME).map

DEBUG=-g3
OPTIM=-O1


CFLAGS= $(DEBUG) \
		$(OPTIM) \
		-T$(LDSCRIPT) \
		-I . \
		-I $(RTOS_SOURCE_DIR)/include \
		-I $(RTOS_SOURCE_DIR)/portable/GCC/ARM7_LPC23xx \
		-I $(DEMO_INCLUDE_DIR) \
		-I $(LPCUSB_COMMON_DIR) -D LPC23xx -DLPC2378_PORTB \
		-I ../Common/drivers/LPC/ \
		-D ROWLEY_LPC23xx \
		-D THUMB_INTERWORK \
		-mcpu=arm7tdmi \
		-D PACK_STRUCT_END=__attribute\(\(packed\)\) \
		-D ALIGN_STRUCT_END=__attribute\(\(aligned\(4\)\)\) \
		-fomit-frame-pointer \
		-mthumb-interwork
										
THUMB_SOURCE= \
		main.c \
		./ParTest/ParTest.c \
		$(DEMO_COMMON_DIR)/BlockQ.c \
		$(DEMO_COMMON_DIR)/blocktim.c \
		$(DEMO_COMMON_DIR)/flash.c \
		$(DEMO_COMMON_DIR)/integer.c \
		$(DEMO_COMMON_DIR)/GenQTest.c \
		$(DEMO_COMMON_DIR)/QPeek.c \
		$(DEMO_COMMON_DIR)/dynamic.c \
		$(RTOS_SOURCE_DIR)/list.c \
		$(RTOS_SOURCE_DIR)/queue.c \
		$(RTOS_SOURCE_DIR)/tasks.c \
		$(RTOS_SOURCE_DIR)/portable/GCC/ARM7_LPC23xx/port.c \
		$(RTOS_SOURCE_DIR)/portable/MemMang/heap_2.c 


ARM_SOURCE= \
		../Common/drivers/LPC/serial/serial.c \
		../Common/drivers/LPC/serial/serialISR.c \
		../Common/drivers/LPC/printf/uart0PutChar2.c \
		../Common/drivers/LPC/printf/printf2.c \
		../Common/drivers/LPC/printf/printfHelpers.c \
		$(RTOS_SOURCE_DIR)/portable/GCC/ARM7_LPC23xx/portISR.c \
		$(LPCUSB_COMMON_DIR)/usbcontrol.c \
		$(LPCUSB_COMMON_DIR)/usbhw_lpc.c \
		$(LPCUSB_COMMON_DIR)/usbinit.c \
		$(LPCUSB_COMMON_DIR)/usbstdreq.c

THUMB_OBJS = $(THUMB_SOURCE:.c=.o)
ARM_OBJS = $(ARM_SOURCE:.c=.o)


all: $(PROJECT_NAME).bin

$(PROJECT_NAME).bin : $(PROJECT_NAME).hex
	$(OBJCOPY) $(PROJECT_NAME).elf -O binary $(PROJECT_NAME).bin
	 
$(PROJECT_NAME).hex : $(PROJECT_NAME).elf
	$(OBJCOPY) $(PROJECT_NAME).elf -O ihex $(PROJECT_NAME).hex

$(PROJECT_NAME).elf : $(THUMB_OBJS) $(ARM_OBJS) boot.s Makefile
	$(CC) $(CFLAGS) $(ARM_OBJS) $(THUMB_OBJS) $(LIBS) boot.s $(LINKER_FLAGS) 
	$(CD) -l -S $(PROJECT_NAME).elf > $(PROJECT_NAME).elf.asm
	

$(THUMB_OBJS) : %.o : %.c Makefile FreeRTOSConfig.h
	$(CC) -c $(CFLAGS) -mthumb $< -o $@

$(ARM_OBJS) : %.o : %.c Makefile FreeRTOSConfig.h
	$(CC) -c $(CFLAGS) $< -o $@

clean :
	rm -f $(THUMB_OBJS)
	rm -f $(ARM_OBJS)
	touch Makefile
	rm -f $(PROJECT_NAME).elf
	rm -f $(PROJECT_NAME).hex
	rm -f $(PROJECT_NAME).bin
	rm -f $(PROJECT_NAME).map
	
	
	




