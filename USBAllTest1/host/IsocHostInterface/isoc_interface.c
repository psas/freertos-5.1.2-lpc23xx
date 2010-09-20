#include "isoc_interface.h"

//#define INFO
#define WARNING
#define ERROR
#include "debug.h"
#undef INFO
#undef WARNING
#undef ERROR

int start_communication(struct isoc_context **isoc_ctx, int initial_read_requests)
{
    int ret=0;
    *isoc_ctx = (struct isoc_context *)malloc(sizeof(struct isoc_context));
    if (!*isoc_ctx){
        PRINT_ERROR("Error: to allocated isoc context in start_communication().\n");
        return -1;
    }
    
    ret = libusb_init(&((*isoc_ctx)->libusb_ctx));
	if (ret < 0) {
		PRINT_ERROR("Error: libusb_init\n");
		return -2;
	}

	(*isoc_ctx)->devh = libusb_open_device_with_vid_pid((*isoc_ctx)->libusb_ctx, VID_TO_CLAIM, PID_TO_CLAIM);
    if (!(*isoc_ctx)->devh){
        PRINT_ERROR("Error: libusb_open_device_with_vid_pid.\n");
        return -3;
    }

	ret = libusb_claim_interface((*isoc_ctx)->devh, 2);
	if (ret < 0) {
		PRINT_ERROR("Error: unable to claim interface 2 on usb device %d\n", ret);
		libusb_close((*isoc_ctx)->devh);
		(*isoc_ctx)->devh = NULL;
		return ret;
	}

    
    cqueue_init(&(*isoc_ctx)->transfer_in_cqueue);
    list_init(&(*isoc_ctx)->in_requests_list);
    list_init(&(*isoc_ctx)->transfer_out_list);
   
    start_event_pump(*isoc_ctx);
    start_writer(*isoc_ctx);
    start_reader(*isoc_ctx);
    
    /* Submit initial_read_requests read requests at a time .*/
    pthread_mutex_lock(&(*isoc_ctx)->in_requests_list_mutex);
    for (int r =0;r < initial_read_requests;r++){
        struct isoc_trans *newTrans = (struct isoc_trans *)malloc(sizeof(struct isoc_trans));
        newTrans->isoc_ctx = *isoc_ctx;
        newTrans->is_pending_flag = 0;
        newTrans->transfer = libusb_alloc_transfer(NUM_ISOC_PACKETS_TO_TRANSFER);
        libusb_fill_iso_transfer(
				            newTrans->transfer,
                            (*isoc_ctx)->devh, 
                            ISOC_IN_EP, 
                            newTrans->buffer,
				            MAX_ISOC_PACKET_SIZE, 
                            NUM_ISOC_PACKETS_TO_TRANSFER, 
                            reader_completion_handler,
				            newTrans, 
                            1000);
        libusb_set_iso_packet_lengths(newTrans->transfer, MAX_ISOC_PACKET_SIZE);
        list_push_back((*isoc_ctx)->in_requests_list,newTrans,sizeof(struct isoc_trans));
    }
    pthread_mutex_unlock(&(*isoc_ctx)->in_requests_list_mutex);

    
    return ret;
}

void stop_communication(struct isoc_context *isoc_ctx)
{
    stop_event_pump(isoc_ctx);
    stop_writer(isoc_ctx);
    stop_reader(isoc_ctx);
    free(isoc_ctx);
}

int write_command(struct isoc_context *isoc_ctx, uint8_t *data, int size)
{
    /*Write command to the list*/
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
                            writer_completion_handler,
				            newTrans, 
                            1000);
        libusb_set_iso_packet_lengths(newTrans->transfer, MAX_ISOC_PACKET_SIZE);
        ret = list_push_back(isoc_ctx->transfer_out_list,newTrans,sizeof(struct libusb_transfer));
    pthread_mutex_unlock(&isoc_ctx->transfer_out_list_mutex);   
    return min;
}
int data_available(struct isoc_context *isoc_ctx)
{
    int count=0;
    pthread_mutex_lock(&isoc_ctx->transfer_in_cqueue_mutex);
        count = cqueue_count(isoc_ctx->transfer_in_cqueue);
    pthread_mutex_unlock(&isoc_ctx->transfer_in_cqueue_mutex);
    return count;
}

int read_data(struct isoc_context *isoc_ctx, uint8_t *data, int size)
{
    /*Read data from the cqueue*/
    pthread_mutex_lock(&isoc_ctx->transfer_in_cqueue_mutex);
        cqueue_front(isoc_ctx->transfer_in_cqueue,data,size);
        cqueue_dequeue(isoc_ctx->transfer_in_cqueue);
    pthread_mutex_unlock(&isoc_ctx->transfer_in_cqueue_mutex);
    return size;
}

void* event_pump_thread(void* param)
{
    struct timeval poll_timeout;
    struct isoc_trans *trans;
    struct isoc_context *isoc_ctx = (struct isoc_context *)param;
	poll_timeout.tv_sec = 0;
	poll_timeout.tv_usec = 10000;
    PRINT_INFO("Info: Hello event pump thread.\n");
    while (!isoc_ctx->event_pump_thread_should_stop){
        libusb_handle_events_timeout(isoc_ctx->libusb_ctx, &poll_timeout);
    }
    PRINT_INFO("Info: Goodbye event pump thread.\n");
}

void reader_completion_handler(struct libusb_transfer *transfer)
{
    uint32_t the_counter = 0;
    if( transfer->user_data != NULL ) {
		struct isoc_trans *sp = (struct isoc_trans *) transfer->user_data;
		sp->is_pending_flag = 0;
	    PRINT_INFO("Info: READ transfer completed, status=%d, length=%d, actual_length=%d, num_iso_packets=%d\n", transfer->status,transfer->length, transfer->actual_length,transfer->num_iso_packets);
	    unsigned char *pbuf = transfer->buffer;
        int i;
	    for (i = 0; i < transfer->num_iso_packets; i++) {
		    struct libusb_iso_packet_descriptor *desc =	&transfer->iso_packet_desc[i];
		    PRINT_INFO("Info: \tpacket %d has length %d, actual_length = %d  ", i, desc->length, desc->actual_length);
		    if (desc->status != 0) {
			    PRINT_WARNING("Warning: \t\t\npacket %d has status %d\n", i, desc->status);
			    continue;
		    }
            memcpy(&the_counter, pbuf, sizeof(the_counter));
            pbuf += desc->actual_length;
		    PRINT_INFO("Info: The counter = %u\n", the_counter);

            pthread_mutex_lock(&sp->isoc_ctx->transfer_in_cqueue_mutex);
                cqueue_enqueue(sp->isoc_ctx->transfer_in_cqueue,&the_counter,sizeof(the_counter));
            pthread_mutex_unlock(&sp->isoc_ctx->transfer_in_cqueue_mutex);
		
	    }
    }
}

void writer_completion_handler(struct libusb_transfer *transfer)
{
     /* ... */
   
	if( transfer->user_data != NULL ) {
        PRINT_INFO("Info: WRITE completed...");
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
                    PRINT_INFO("Info: Removed From List.\n");
                    break;
                }
            }
        }else{
            PRINT_ERROR("Error: WRITE completion not Found!\n");
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
        PRINT_ERROR("Error: pthread_create( event pump ).\n");
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
    struct isoc_context *isoc_ctx = (struct isoc_context*)param;
    PRINT_INFO("Info: Hello reader thread\n");
    while (!isoc_ctx->reader_thread_should_stop)
    {
        /* Read Commands */
        pthread_mutex_lock(&isoc_ctx->in_requests_list_mutex);
        if (list_count(isoc_ctx->in_requests_list)>0){
            struct list_element *ele = isoc_ctx->in_requests_list->front;
            for (;ele;ele = ele->next){
                if (!((struct isoc_trans*)ele->data)->is_pending_flag){
                    ((struct isoc_trans*)ele->data)->is_pending_flag=1;
                    int ret = libusb_submit_transfer(((struct isoc_trans*)ele->data)->transfer);
                    if (ret != 0){
                        PRINT_ERROR("Error: READ NOT Submitted: %i\n",ret);
                    }else{
                        PRINT_INFO("Info: READ Submitted\n");
                    }
                }else{
                    PRINT_INFO("Info: READ pending\n");  
                }
            }           
        }
        pthread_mutex_unlock(&isoc_ctx->in_requests_list_mutex);   
        usleep(1000);
    }
    PRINT_INFO("Info: Goodbye reader thread\n");
}



void* writer_thread(void *param)
{
    struct isoc_context *isoc_ctx = (struct isoc_context*)param;
    PRINT_INFO("Info: Hello writer thread\n");
    while (!isoc_ctx->writer_thread_should_stop)
    {
        /* Write Commands */
        pthread_mutex_lock(&isoc_ctx->transfer_out_list_mutex);
        if (list_count(isoc_ctx->transfer_out_list)>0){
            struct list_element *ele = isoc_ctx->transfer_out_list->front;
            for (;ele;ele = ele->next){
                if (!((struct isoc_trans*)ele->data)->is_pending_flag){
                    ((struct isoc_trans*)ele->data)->is_pending_flag=1;
                    int ret = libusb_submit_transfer(((struct isoc_trans*)ele->data)->transfer);
                    if (ret != 0){
                        PRINT_ERROR("Error: WRITE NOT Submitted: %i\n",ret);
                    }else{
                        PRINT_INFO("Info: WRITE Submitted\n");
                    }
                }else{
                    PRINT_INFO("Info: WRITE pending\n");  
                }
            }           
        }
        pthread_mutex_unlock(&isoc_ctx->transfer_out_list_mutex);   
        usleep(1000);
    }
    PRINT_INFO("Info: Goodbye writer thread\n");
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
        PRINT_ERROR("Error: pthread_create( writer ).\n");
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
    int ret;
    pthread_mutex_init(&isoc_ctx->transfer_in_cqueue_mutex,NULL);
    pthread_mutex_init(&isoc_ctx->in_requests_list_mutex,NULL);
    isoc_ctx->reader_thread_should_stop=0;
    ret = pthread_create(&isoc_ctx->reader_thread_handle, 
                   NULL,
                   reader_thread,
                   isoc_ctx);
    if (ret <0){//Fail
        PRINT_ERROR("Error: pthread_create( reader ).\n");
        return ret;
    }    

    return ret;
}

void stop_reader(struct isoc_context *isoc_ctx)
{
    isoc_ctx->reader_thread_should_stop=1;
    pthread_join(isoc_ctx->reader_thread_handle,NULL);
}
