PROJ_ROOT=..
CFLAGS=-I$(PROJ_ROOT)/debug/ -std=c99 -g3 #-Wl,--verbose -H
LDFLAGS=
LDLIBS=
CC=gcc

all:    list_test

list_test:    list.o list_test.o
	$(CC) $(LDFLAGS) -o list_test list_test.o list.o $(LDLIBS)

list_test.o:	list_test.c
	$(CC) $(CFLAGS) -c list_test.c

list.o:   list.c list.h
	$(CC) $(CFLAGS) -c list.c

clean:
	rm -f *.o list_test
