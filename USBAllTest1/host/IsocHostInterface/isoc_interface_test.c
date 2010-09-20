#include "isoc_interface.h"
#include <pthread.h>

#define INFO
#define WARNING
#define ERROR
#include "debug.h"
#undef INFO
#undef WARNING
#undef ERROR

int reader_thread_should_stop=0;
int writer_thread_should_stop=0;
pthread_t    reader_thread_handle;
pthread_t    writer_thread_handle;

int start_reader_thread(struct isoc_context *isoc_ctx);
int start_writer_thread(struct isoc_context *isoc_ctx);
void stop_reader_thread();
void stop_writer_thread();
void *test_reader_thread(void *param);
void *test_writer_thread(void *param);


int main(int argc, char **argv)
{
    struct isoc_context *isoc_ctx=NULL;
    int count=0;
    start_communication(&isoc_ctx,10);
    start_reader_thread(isoc_ctx);
    start_writer_thread(isoc_ctx);

    for(;count < 25;count++){usleep(1000000);}//sleep for 25 seconds

    stop_reader_thread();
    stop_writer_thread();
    stop_communication(isoc_ctx);
    return 0;
}

int start_reader_thread(struct isoc_context *isoc_ctx)
{   
    int ret;
    reader_thread_should_stop=0;
    ret = pthread_create(&reader_thread_handle, 
                   NULL,
                   test_reader_thread,
                   isoc_ctx);
    if (ret <0){//Fail
        PRINT_ERROR("Error: pthread_create( reader ).\n");
        return ret;
    }    
}

int start_writer_thread(struct isoc_context *isoc_ctx)
{   
    int ret;
    writer_thread_should_stop=0;    
    ret = pthread_create(&writer_thread_handle, 
                   NULL,
                   test_writer_thread,
                   isoc_ctx);
    if (ret <0){//Fail
        PRINT_ERROR("Error: pthread_create( writer ).\n");
        return ret;
    }    
}

void stop_reader_thread()
{
    reader_thread_should_stop=1;    
    pthread_join(reader_thread_handle,NULL);
}

void stop_writer_thread()
{
    writer_thread_should_stop=1;    
    pthread_join(writer_thread_handle,NULL);
}
void *test_reader_thread(void *param)
{
    struct isoc_context *isoc_ctx = (struct isoc_context*)param;
    uint32_t iter=0;
    uint32_t the_counter1, the_counter2;
    uint8_t inBuffer[1024*128];
    while(!reader_thread_should_stop)
    {
        while (data_available(isoc_ctx)){
            read_data(isoc_ctx,inBuffer,1024*128);

            the_counter1 = the_counter2;
            the_counter2 = *((uint32_t*)inBuffer);
            if (the_counter1 != (the_counter2-1) && iter > 10){
                PRINT_WARNING("Warning: Dropped a packet, diff=%i\n",the_counter2-1-the_counter1);
            }

            //printf("Counter = %i\n",*((uint32_t*)inBuffer));
        }
        iter++;
    }
    return 0;
}
void *test_writer_thread(void *param)
{
    printf("Hello\n");
    struct isoc_context *isoc_ctx = (struct isoc_context*)param;
    uint8_t ledStatus=0;
    while(!writer_thread_should_stop)
    {
        ledStatus ^= 1;
        write_command(isoc_ctx,&ledStatus,sizeof(uint8_t));
        usleep(500000);
    }
    printf("GoodBye\n");
    return 0;
}
