PROJ_ROOT=..
CFLAGS=-I$(PROJ_ROOT)/list/ -std=c99 -g3 -Wl,--verbose -H
LDFLAGS=-L/usr/local/lib/ 
LDLIBS=-pthread -lrt 
CC=gcc

all:    isoc_interface_test

isoc_interface_test:    list.o isoc_interface_test.o
	$(CC) $(LDFLAGS) -o isoc_interface_test isoc_interface_test.o  list.o /usr/local/lib/libusb-1.0.a $(LDLIBS)


isoc_interface_test.o:  isoc_interface_test.c
	$(CC) $(CFLAGS) -c isoc_interface_test.c

list.o: $(PROJ_ROOT)/list/list.c $(PROJ_ROOT)/list/list.h
	$(CC) $(CFLAGS) -c $(PROJ_ROOT)/list/list.c

clean:
	rm -f *.o isoc_interface_test

