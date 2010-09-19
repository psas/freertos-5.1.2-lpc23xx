#include "isoc_interface.h"

int main(int argc, char **argv)
{
    struct isoc_context *isoc_ctx=NULL;
    int done=-1000;    
    uint8_t ledStatus=0;
    start_communication(&isoc_ctx);    
    /*while (done < 0){        
        ledStatus ^= 1;
        write_command(isoc_ctx,&ledStatus,sizeof(uint8_t));
        usleep(500000);
        done++;
    }*/
    while(1){usleep(10000);}
    usleep(1000000);
    stop_communication(isoc_ctx);
    return 0;
}


