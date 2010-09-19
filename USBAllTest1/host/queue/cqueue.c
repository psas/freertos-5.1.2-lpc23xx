#include "cqueue.h"
#include "debug.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define MIN(x,y)   (x<=y)?x:y

int cqueue_init(struct cqueue **cq){
    *cq = (struct cqueue*)malloc(sizeof(struct cqueue));
    if (!*cq){
        PRINT_DEBUG("Failed: cqueue_init unable to allocate memory.\n");
        return -1;//No Memory!
    }

    (*cq)->head_index = 0;
    (*cq)->tail_index = 0;

    return 0;//Success 
}
void  cqueue_enqueue(struct cqueue *cq, void *data, int size){
    if (cq->tail_index == cq->head_index && cqueue_count(cq) > 0){//full
        cq->head_index = cqueue_get_next_index(cq->head_index);//this overwrites the oldest data
        PRINT_DEBUG("Warning: oldest data overwritten.\n");
        cq->enqueued--;//cancel out the auto increment that's below...we're not adding more, just replacing.
    }
    memcpy(&cq->elements[cq->tail_index].data,data,size);
    cq->elements[cq->tail_index].size = size;
    cq->tail_index = cqueue_get_next_index(cq->tail_index);    
    
    cq->enqueued++;
    PRINT_DEBUG("Enqueued\n");
}
int cqueue_dequeue(struct cqueue *cq){
    if (cqueue_count(cq)==0){
        PRINT_DEBUG("Failed: attempted cqueue_dequeue on empty queue.\n");
        return -1;
    }
    cq->elements[cq->head_index].size = 0;
    cq->head_index = cqueue_get_next_index(cq->head_index);
    cq->dequeued++;
    PRINT_DEBUG("Dequeued\n");
    return cq->dequeued;
}
int cqueue_front(struct cqueue *cq, void *data, int size){
     if (cqueue_count(cq)==0){
        PRINT_DEBUG("Failed: attempted cqueue_front on empty queue.\n");
        return -1;
    }
    int min = MIN(size, cq->elements[cq->head_index].size);
    memcpy(data,&cq->elements[cq->head_index],min);
    return min;
}

int  cqueue_is_empty(struct cqueue *cq){
    return (cq->enqueued - cq->dequeued) ? 0 : 1;
}
int  cqueue_is_full(struct cqueue *cq){
    return (cq->enqueued - cq->dequeued) ? 1 : 0;
}
int  cqueue_count(struct cqueue *cq){
    return (cq->enqueued - cq->dequeued);
}

int cqueue_get_next_index(int current_index){
    return (current_index + 1) % CQUEUE_MAX_SIZE;
}
