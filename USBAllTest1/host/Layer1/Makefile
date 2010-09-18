PROJ_ROOT=..
CFLAGS=-I/usr/local/include/ -I$(PROJ_ROOT)/list/ -std=c99 -g3 -H 
LFLAGS=-shared -L/usr/local/lib/ -pthread -lrt
CC=gcc

all:    layer1_test

layer1_test:    list.o layer1_test.o
	$(CC) $(LFLAGS) -o layer1_test.o $(PROJ_ROOT)/libusb-1.0.8/libusb/.libs/libusb-1.0.a

layer1_test.o:  layer1_test.c
	$(CC) $(CFLAGS) -c layer1_test.c

list.o: $(PROJ_ROOT)/list/list.c $(PROJ_ROOT)/list/list.h
	$(CC) $(CFLAGS) -c $(PROJ_ROOT)/list/list.c


