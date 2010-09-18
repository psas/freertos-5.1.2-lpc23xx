#include "isoc_interface.h"

int start_communication(struct isoc_context **isoc_ctx)
{
    int ret=0;
    *isoc_ctx = (struct isoc_context *)malloc(sizeof(struct isoc_context));
    if (!*isoc_ctx){
        printf("Failed: to allocated isoc context in start_communication().\n");
        return -1;
    }
    
    ret = libusb_init(&((*isoc_ctx)->libusb_ctx));
	if (ret < 0) {
		printf("Failed: libusb_init\n");
		return -2;
	}

	(*isoc_ctx)->devh = libusb_open_device_with_vid_pid((*isoc_ctx)->libusb_ctx, VID_TO_CLAIM, PID_TO_CLAIM);
    if (!(*isoc_ctx)->devh){
        printf("Failed: libusb_open_device_with_vid_pid.\n");
        return -3;
    }

	ret = libusb_claim_interface((*isoc_ctx)->devh, 2);
	if (ret < 0) {
		printf("unable to claim interface 2 on usb device %d\n", ret);
		libusb_close((*isoc_ctx)->devh);
		(*isoc_ctx)->devh = NULL;
		return ret;
	}

    //cqueue_init(&transfer_in_cqueue);
    list_init(&(*isoc_ctx)->transfer_out_list);

    start_event_pump(*isoc_ctx);
    start_writer(*isoc_ctx);
    //start_reader(*isoc_ctx);

    return ret;
}

void stop_communication(struct isoc_context *isoc_ctx)
{
    stop_event_pump(isoc_ctx);
    stop_writer(isoc_ctx);
    //stop_reader();
    free(isoc_ctx);
}

int write_command(struct isoc_context *isoc_ctx, uint8_t *data, int size)
{
    /*Write a command to the list*/
    int ret=0;
    pthread_mutex_lock(&isoc_ctx->transfer_out_list_mutex);    
        struct isoc_trans *newTrans = (struct isoc_trans *)malloc(sizeof(struct isoc_trans));
        newTrans->isoc_ctx = isoc_ctx;
        newTrans->is_pending_flag = 0;
        newTrans->transfer = libusb_alloc_transfer(NUM_ISOC_PACKETS_TO_TRANSFER);
        int min = MIN(size, MAX_ISOC_PACKET_SIZE * NUM_ISOC_PACKETS_TO_TRANSFER);
        memcpy(newTrans->buffer,data,min);
        libusb_fill_iso_transfer(
				            newTrans->transfer,
                            isoc_ctx->devh, 
                            ISOC_OUT_EP, 
                            newTrans->buffer,
				            MAX_ISOC_PACKET_SIZE, 
                            NUM_ISOC_PACKETS_TO_TRANSFER, 
                            isoc_output_completion_handler,
				            newTrans, 
                            1000);
        libusb_set_iso_packet_lengths(newTrans->transfer, MAX_ISOC_PACKET_SIZE);
        ret = list_push_back(isoc_ctx->transfer_out_list,newTrans,sizeof(struct libusb_transfer));
    pthread_mutex_unlock(&isoc_ctx->transfer_out_list_mutex);   
    return min;
}

int read_data(struct isoc_context *isoc_ctx, uint8_t *data, int size)
{
    /*Read data from the cqueue*/

    return -1;
}

void* event_pump_thread(void* param)
{
    struct timeval poll_timeout;
    struct isoc_trans *trans;
    struct isoc_context *isoc_ctx = (struct isoc_context *)param;
	poll_timeout.tv_sec = 0;
	poll_timeout.tv_usec = 10000;
    printf("Hello event pump thread.\n");
    while (!isoc_ctx->event_pump_thread_should_stop){
        libusb_handle_events_timeout(isoc_ctx->libusb_ctx, &poll_timeout);
    }
    printf("Goodbye event pump thread.\n");
}

//uint32_t last_counter=0;
uint32_t the_counter = 0;
void isoc_input_completion_handler(struct libusb_transfer *transfer)
{
	printf("ISOC INPUT transfer completed, status = %d\n", transfer->status);
	printf("length = %d\n", transfer->length);
	printf("actual_length = %d\n", transfer->actual_length);
	printf("num_iso_packets = %d\n", transfer->num_iso_packets);
    /* ... */
	unsigned char *pbuf = transfer->buffer;
    int i;
	for (i = 0; i < transfer->num_iso_packets; i++) {
		struct libusb_iso_packet_descriptor *desc =	&transfer->iso_packet_desc[i];

		printf("packet %d has length %d, actual_length = %d  ", i, desc->length, desc->actual_length);

		if (desc->status != 0) {
			printf("\npacket %d has status %d\n", i, desc->status);
			continue;
		}
        
/*        last_counter = the_counter;
		memcpy(&the_counter, pbuf, sizeof(the_counter));
   
        if (last_counter != the_counter-1){
            printf("Dropped->%i != %i\n",last_counter, the_counter);
         }*/
    
		printf("The counter = %u\n", the_counter);

		pbuf += desc->actual_length;
	}


	if( transfer->user_data != NULL ) {
		struct isoc_trans *sp = (struct isoc_trans *) transfer->user_data;
		sp->is_pending_flag = 0;
	}
}

void isoc_output_completion_handler(struct libusb_transfer *transfer)
{
     /* ... */
   
	if( transfer->user_data != NULL ) {
        printf("WRITE completed...");
		struct isoc_trans *sp = (struct isoc_trans *) transfer->user_data;
		sp->is_pending_flag = 0;

        /* Find pending command in list and remove it, we're done */
        pthread_mutex_lock(&sp->isoc_ctx->transfer_out_list_mutex);
        if (list_count(sp->isoc_ctx->transfer_out_list)>0){
            struct isoc_trans *submittableTrans;
            struct list_element *ele = sp->isoc_ctx->transfer_out_list->front;
            for (;ele;ele = ele->next){
                if (ele->data == sp){
                    list_del(sp->isoc_ctx->transfer_out_list,ele);
                    printf("Removed From List.\n");
                    break;
                }
            }
        }else{
            printf("WRITE completion not Found!\n");
        }
        pthread_mutex_unlock(&sp->isoc_ctx->transfer_out_list_mutex);
	}
}

int start_event_pump(struct isoc_context *isoc_ctx)
{
    int ret;
    isoc_ctx->event_pump_thread_should_stop=0;
    ret = pthread_create(&isoc_ctx->event_pump_thread_handle, 
                   NULL,
                   event_pump_thread,
                   isoc_ctx);
    if (ret <0){//Fail
        printf("Failed: pthread_create( event pump ).\n");
        return ret;
    }    
}

void stop_event_pump(struct isoc_context *isoc_ctx)
{
    isoc_ctx->event_pump_thread_should_stop=1;
    pthread_join(isoc_ctx->event_pump_thread_handle,NULL);
}

void* reader_thread(void *param)
{
}



void* writer_thread(void *param)
{
    struct isoc_context *isoc_ctx = (struct isoc_context*)param;
    printf("Hello writer thread\n");
    while (!isoc_ctx->writer_thread_should_stop)
    {
        /* Write Commands */
        pthread_mutex_lock(&isoc_ctx->transfer_out_list_mutex);
        if (list_count(isoc_ctx->transfer_out_list)>0){
            struct isoc_trans *submittableTrans;
            struct list_element *ele = isoc_ctx->transfer_out_list->front;
            for (;ele;ele = ele->next){
                if (!((struct isoc_trans*)ele->data)->is_pending_flag){
                    ((struct isoc_trans*)ele->data)->is_pending_flag=1;
                    int ret = libusb_submit_transfer(((struct isoc_trans*)ele->data)->transfer);
                    if (ret != 0){
                        printf("WRITE NOT Submitted: %i\n",ret);
                    }else{
                        printf("WRITE Submitted\n");
                    }
                }else{
                    printf("WRITE pending\n");  
                }
            }           
        }
        pthread_mutex_unlock(&isoc_ctx->transfer_out_list_mutex);   
        usleep(500000);
    }
    printf("Goodbye writer thread\n");
}

int start_writer(struct isoc_context *isoc_ctx)
{
    int ret;
    pthread_mutex_init(&isoc_ctx->transfer_out_list_mutex,NULL);
    isoc_ctx->writer_thread_should_stop=0;
    ret = pthread_create(&isoc_ctx->writer_thread_handle, 
                   NULL,
                   writer_thread,
                   isoc_ctx);
    if (ret <0){//Fail
        printf("Failed: pthread_create( writer ).\n");
        return ret;
    }    

    return ret;
}

void stop_writer(struct isoc_context *isoc_ctx)
{
    isoc_ctx->writer_thread_should_stop=1;
    pthread_join(isoc_ctx->writer_thread_handle,NULL);
}

int start_reader(struct isoc_context *isoc_ctx)
{
    //pthread_mutex_init(&isoc_ctx->transfer_in_queue_mutex,NULL);
    return -1;
}

void stop_reader(struct isoc_context *isoc_ctx)
{
}
