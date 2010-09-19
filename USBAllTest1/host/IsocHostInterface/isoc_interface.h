#ifndef ISOC_INTERFACE_H_
#define ISOC_INTERFACE_H_

/*
    Isochronous transfers are such that USB will transfer a Isoc packet every 1ms.
    As a user, we are responsible for interpretting the Isoc packet.
    If an Isoc packet is 128 bytes, and the commands we are sending to the sensor node
    are 4 bytes; we pack up the Isoc packet with our commands and than 
    for every Isoc packet transfered we are sending 128/4 = 32 commands every 1ms.
    So, this means we have a command transfer rate of 32 Khz.

    To Compile
        clear;gcc -g -o isoc_interface_test isoc_interface_test.c --std=c99
*/

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "list.h"
#include "cqueue.h"
#include <libusb-1.0/libusb.h>
#include <pthread.h>


#define VID_TO_CLAIM                    0xFFFF
#define PID_TO_CLAIM                    0x0005
#define ISOC_OUT_EP                     0x06
#define ISOC_IN_EP                      0x83
#define MAX_ISOC_PACKET_SIZE            128
#define NUM_ISOC_PACKETS_TO_TRANSFER    1
#define MAX_ISOC_IN_TRANSFERS           50
#define MAX_ISOC_OUT_TRANSFERS          1

#define MIN(x,y)   (x<=y)?x:y

/* Internal structures and variables */
struct isoc_context
{
    //TODO: implement transfer_in_cqueue
    struct cqueue *transfer_in_cqueue;
    struct list *in_requests_list;
    struct list *transfer_out_list;


    pthread_mutex_t transfer_in_cqueue_mutex;
    pthread_mutex_t in_requests_list_mutex;
    pthread_mutex_t transfer_out_list_mutex;
    pthread_t event_pump_thread_handle;
    pthread_t reader_thread_handle;
    pthread_t writer_thread_handle;    
    int event_pump_thread_should_stop;
    int reader_thread_should_stop;
    int writer_thread_should_stop;

    struct libusb_context *libusb_ctx;
    struct libusb_device_handle *devh;
};

struct isoc_trans {
    struct isoc_context *isoc_ctx;

	struct libusb_transfer *transfer;
	uint8_t buffer[MAX_ISOC_PACKET_SIZE * NUM_ISOC_PACKETS_TO_TRANSFER];
	int is_pending_flag;
};


/* Public Interface */
/*
    read data - issuing IN requests. that are issued quickly and repeatedly.
    write commands - issuing OUT requests. that are occasionally submitted to the sensor node.
                
    *A command is issued via submit_write. the commands are put into a list fifo style.
    *Data is read via submit_read. data is read off of a circular queue.

    *a dedicated thread continuously runs which 
*/
int  start_communication(struct isoc_context **isoc_ctx);
void stop_communication(struct isoc_context *isoc_ctx);
int write_command(struct isoc_context *isoc_ctx,uint8_t *data, int size);
int data_available(struct isoc_context *isoc_ctx);
int read_data(struct isoc_context *isoc_ctx,uint8_t *data, int size);

/* Internal stuff */
void reader_completion_handler(struct libusb_transfer *transfer);
void writer_completion_handler(struct libusb_transfer *transfer);

void* event_pump_thread(void *param);
int start_event_pump(struct isoc_context *isoc_ctx);
void stop_event_pump(struct isoc_context *isoc_ctx);

void* reader_thread(void *param);
int start_reader(struct isoc_context *isoc_ctx);
void stop_reader(struct isoc_context *isoc_ctx);

void* writer_thread(void *param);
int start_writer(struct isoc_context *isoc_ctx);
void stop_writer(struct isoc_context *isoc_ctx);



#endif

