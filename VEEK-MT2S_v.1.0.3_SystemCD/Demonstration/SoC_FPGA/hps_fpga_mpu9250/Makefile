#
TARGET = hps_fpga_mpu9250
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -static -g -Wall -std=c++11 -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/ 
LDFLAGS =  -g -Wall  
CC = $(CROSS_COMPILE)g++
ARCH= arm


build: $(TARGET)


$(TARGET): hps_fpga_mpu9250.o  MPU9250.o
	$(CC) $(LDFLAGS)   $^ -o $@   -lrt -lm
%.o : %.cpp
	$(CC) $(CFLAGS) -c $< -o $@
	

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~ *.bmp