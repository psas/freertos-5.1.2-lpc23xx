#include "cqueue.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cqueue_init(struct cqueue **cq){
    *cq = (struct cqueue*)malloc(sizeof(struct cqueue));
    if (!*cq){
        printf("Failed: cqueue_init unable to allocate memory.\n");
        return -1;//No Memory!
    }

    (*cq)->head_index = 0;
    (*cq)->tail_index = 0;

    return 0;//Success 
}
void  cqueue_enqueue(struct cqueue *cq, void *data, int size){
    memcpy(&cq->elements[cq->tail_index].payload,data,size);
    cq->elements[cq->tail_index].size = size;
    cq->tail_index = cqueue_get_next_index(cq->tail_index);
    cq->enqueued++;
}
void  cqueue_dequeue(struct cqueue *cq){
    cq->elements[cq->head_index].size = 0;
    cq->head_index = cqueue_get_next_index(cq->head_index);
    cq->dequeued++;
}
int cqueue_front(struct cqueue *cq, void *data, int size){
    memcpy(data,&cq->elements[cq->head_index],size);
    return cq->elements[cq->head_index].size;
}
void cqueue_get_next(struct cqueue *cq, struct *cqueue_next_state){
    int ret= cq->elements[cqueue_next_state->next_index].size;
    memcpy(data,&cq->elements[cqueue_next_state->next_index],size);
    cqueue_next_state->next_index = cqueue_get_next_index(cqueue_next_state->next_index);
    
    return ret;
}
int cqueue_get_head_index(struct cqueue *cq){
    return cq->head_index;
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
