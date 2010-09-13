#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include "./libusb-1.0.8/libusb/libusb.h"

/*
 * This is a test program, that utilizes libusb 1.0, to do ISOC transfers to and from
 * the isoc_io_sample.c sample firmware in the LPCUSB target source tree.
 *
 * You will need to install libusb-1.0 on your host computer in order for this to work.
 * It has only been tested under linux.
 *
 * It will read data from the device (a increasing counter value) and write
 * data to the device in order to control the LED on the olimex development board
 * from the host.
 *
 * Due to kernel timing characteristics, ISOC transfers are batched, such that we can get
 * a transfer every 1ms to/from the device.
 *
 * When you run this, you should expect to see it output a hexidecimal value that is constantly
 * increasing, and you should see the LED on the olimex dev board blink only when this program
 * is running (because this program will be telling it to blink).
 */

#define VID_TO_CLAIM    0xFFFF
#define PID_TO_CLAIM    0x0005


#define ISOC_OUT_EP     0x06
#define ISOC_IN_EP      0x83
#define MAX_ISOC_PACKET_SIZE	128
#define NUM_ISO_PACKETS_TO_TRANSFER   1

struct isoc_trans {
	struct libusb_transfer *transfer_buff;
	uint8_t isoc_buffer[MAX_ISOC_PACKET_SIZE * NUM_ISO_PACKETS_TO_TRANSFER];
	int is_pending_flag;
};

int is_write_pending_flag=0;
uint8_t isoc_output_buffer[MAX_ISOC_PACKET_SIZE];

#define MAX_ISOC_TRANSFERS   50
struct isoc_trans transfer_array[MAX_ISOC_TRANSFERS];

libusb_context *ctx=NULL;

void isoc_output_transfer_completion_handler(struct libusb_transfer *transfer)
{
	printf("ISOC OUTPUT transfer completed\n");

     /* ... */
is_write_pending_flag=0;
}
int first=1;
uint32_t last_counter=0;
uint32_t the_counter = 0;
void isoc_transfer_completion_handler(struct libusb_transfer *transfer)
{
	printf("The isoc transfer has completed, status = %d\n", transfer->status);
	printf("length = %d\n", transfer->length);
	printf("actual_length = %d\n", transfer->actual_length);
	printf("num_iso_packets = %d\n", transfer->num_iso_packets);
    /* ... */
	unsigned char *pbuf = transfer->buffer;
	for (int i = 0; i < transfer->num_iso_packets; i++) {
		struct libusb_iso_packet_descriptor *desc =	&transfer->iso_packet_desc[i];

		printf("packet %d has length %d, actual_length = %d  ", i, desc->length, desc->actual_length);

		if (desc->status != 0) {
			printf("\npacket %d has status %d\n", i, desc->status);
			continue;
		}
        
        last_counter = the_counter;
		memcpy(&the_counter, pbuf, sizeof(the_counter));
   
        if (last_counter != the_counter-1){
            printf("Dropped->%i != %i\n",last_counter, the_counter);
         }
    
		printf("The counter = %u\n", the_counter);

		pbuf += desc->actual_length;
	}


	if( transfer->user_data != NULL ) {
		struct isoc_trans *sp = (struct isoc_trans *) transfer->user_data;
		sp->is_pending_flag = 0;
	}


}

pthread_t libusb_internal_event_thread_handle;
int libusb_internal_event_thread_should_be_done=0;



void* libusb_internal_event_thread(void* param);
int start_libusb_event_pump()
{
    int ret;
    ret = pthread_create(&libusb_internal_event_thread_handle, 
                   NULL,
                   libusb_internal_event_thread,
                   NULL);
    if (!ret){//success
        libusb_internal_event_thread_should_be_done=0;
    }else{
        printf("Failed to start libusb event pump!\n");
    }

    return ret;
}

void* libusb_internal_event_thread(void* param)
{
    struct timeval poll_timeout;
	poll_timeout.tv_sec = 0;
	poll_timeout.tv_usec = 100;
    printf("Hello libusb_internal_event_thread.\n");
    while (!libusb_internal_event_thread_should_be_done){
        libusb_handle_events_timeout(ctx, &poll_timeout);
    }
    printf("Goodbye libusb_internal_event_thread.\n");
}
void stop_libusb_event_pump()
{
    pthread_join(libusb_internal_event_thread_handle,NULL);
}


int main(int argc, char **argv)
{
	int current_led_status = 0;

	int r = libusb_init(&ctx);
	if (r < 0) {
		printf("failed to init libusb\n");
		return (-1);
	}

	libusb_device_handle *devh = libusb_open_device_with_vid_pid(ctx, VID_TO_CLAIM, PID_TO_CLAIM);

	r = libusb_claim_interface(devh, 2);
	if (r < 0) {
		printf("unable to claim interface 2 on usb device %d\n", r);
		libusb_close(devh);
		devh = NULL;
		return (r);
	}

	struct libusb_transfer *isoc_output_transfer = libusb_alloc_transfer(1);

	memset(transfer_array, 0, sizeof(transfer_array));

	for(int i = 0; i < MAX_ISOC_TRANSFERS; i++ ) {
		transfer_array[i].is_pending_flag = 0;
		transfer_array[i].transfer_buff = libusb_alloc_transfer(NUM_ISO_PACKETS_TO_TRANSFER);
	}

	struct timeval poll_timeout;
	poll_timeout.tv_sec = 0;
	poll_timeout.tv_usec = 1000;

    int turnstyle=0;
    start_libusb_event_pump();
    usleep(500);
	for (;1;){//int loopLimit = 0; loopLimit < 10000; loopLimit++) {
	    for(int i = 0; i < MAX_ISOC_TRANSFERS; i++ ) {
		    if( transfer_array[i].is_pending_flag ) {
			    continue;
		    }

		    printf("Submitting isoc READ transfer request\n");
		    memset(transfer_array[i].isoc_buffer, 0, sizeof(transfer_array[i].isoc_buffer));

		    libusb_fill_iso_transfer(
				    transfer_array[i].transfer_buff, devh, ISOC_IN_EP, transfer_array[i].isoc_buffer,
				    MAX_ISOC_PACKET_SIZE, NUM_ISO_PACKETS_TO_TRANSFER, isoc_transfer_completion_handler,
				    &transfer_array[i], 1000);

		    libusb_set_iso_packet_lengths(transfer_array[i].transfer_buff, MAX_ISOC_PACKET_SIZE);
		    transfer_array[i].is_pending_flag = 1;

		    r = libusb_submit_transfer(transfer_array[i].transfer_buff);
            if (r != 0){
                printf("Submit isoc READ FAILED: %i\n",r);
            }           
	    }
        if (is_write_pending_flag){
            continue;
        }
        if ((turnstyle++ % 1000000) == 0){
            printf("Submitting isoc WRITE transfer request\n");
            libusb_fill_iso_transfer(
                    isoc_output_transfer, devh, ISOC_OUT_EP, isoc_output_buffer,
                    MAX_ISOC_PACKET_SIZE, 1, isoc_output_transfer_completion_handler,
                    NULL, 1000);

            libusb_set_iso_packet_lengths(isoc_output_transfer, MAX_ISOC_PACKET_SIZE);
            isoc_output_transfer->iso_packet_desc[0].actual_length = 1;
            isoc_output_transfer->iso_packet_desc[0].length = MAX_ISOC_PACKET_SIZE;

            isoc_output_buffer[0] ^= 1;

            r= libusb_submit_transfer(isoc_output_transfer);

            if (r != 0){
                printf("Submit isoc WRITE FAILED: %i\n",r);
            }else{
                is_write_pending_flag=1;
            }
        }        
    }

    libusb_internal_event_thread_should_be_done=1;
    stop_libusb_event_pump();
   

	//libusb_free_transfer(transfer_buff);

	libusb_release_interface(devh, 2);

	return (0);
}
