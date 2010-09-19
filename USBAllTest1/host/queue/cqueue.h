#ifndef CQUEUE_H_
#define CQUEUE_H_
#include <stdint.h>
    
/*
    when enqueing, if tail wraps around to the head, the head must be incremented..
*/

#define CQUEUE_MAX_SIZE             1024*128
#define CQUEUE_MAX_PAYLOAD_SIZE     128
struct cqueue_element
{
    uint8_t data[CQUEUE_MAX_PAYLOAD_SIZE];
    int size;
    int sequence;
    int status;
};

struct cqueue
{
    struct cqueue_element elements[CQUEUE_MAX_SIZE];
    int head_index;
    int tail_index;  

    uint32_t enqueued;
    uint32_t dequeued;  
};


int  cqueue_init(struct cqueue **cq);
void  cqueue_enqueue(struct cqueue *cq, void *data, int size);
int  cqueue_dequeue(struct cqueue *cq);
int  cqueue_front(struct cqueue *cq, void *data, int size);
int  cqueue_back(struct cqueue *cq, void *data, int size);
int  cqueue_is_empty(struct cqueue *cq);
int  cqueue_is_full(struct cqueue *cq);
int  cqueue_count(struct cqueue *cq);

int cqueue_get_next_index(int current_index);


#endif

