PROJ_ROOT=..
CFLAGS=-I$(PROJ_ROOT)/list/ -I$(PROJ_ROOT)/queue/ -I$(PROJ_ROOT)/debug/ -std=c99 -g3 #-Wl,--verbose -H
LDFLAGS=-L/usr/local/lib/ 
LDLIBS=-pthread -lrt 
CC=gcc

all:    isoc_interface_test

isoc_interface_test:    cqueue.o list.o isoc_interface.o isoc_interface_test.o
	$(CC) $(LDFLAGS) -o isoc_interface_test isoc_interface_test.o  isoc_interface.o list.o cqueue.o /usr/local/lib/libusb-1.0.a $(LDLIBS)


isoc_interface_test.o:  isoc_interface_test.c isoc_interface.c isoc_interface.h
	$(CC) $(CFLAGS) -c isoc_interface_test.c isoc_interface.c

cqueue.o:   $(PROJ_ROOT)/queue/cqueue.c $(PROJ_ROOT)/queue/cqueue.h
	$(CC) $(CFLAGS) -c $(PROJ_ROOT)/queue/cqueue.c

list.o: $(PROJ_ROOT)/list/list.c $(PROJ_ROOT)/list/list.h
	$(CC) $(CFLAGS) -c $(PROJ_ROOT)/list/list.c

clean:
	rm -f *.o isoc_interface_test

