PROJ_ROOT=..
CFLAGS=-std=c99 -g3 #-Wl,--verbose -H
LDFLAGS= 
LDLIBS= 
CC=gcc

all:    cqueue_test

cqueue_test:    cqueue.o cqueue_test.o
	$(CC) $(LDFLAGS) -o cqueue_test cqueue_test.o  cqueue.o $(LDLIBS)


cqueue_test.o:  cqueue_test.c cqueue.c cqueue.h
	$(CC) $(CFLAGS) -c cqueue_test.c cqueue.c


clean:
	rm -f *.o cqueue_test

