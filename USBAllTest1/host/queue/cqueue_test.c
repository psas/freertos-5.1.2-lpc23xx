#include "cqueue.h"
#include <stdio.h>

struct cqueue *cq;
/* Expected output:

    Enqueued
    Enqueued
    Enqueued
    Warning: oldest data overwritten.
    Enqueued
    0) buffer = B
    Dequeued
    1) buffer = C
    Dequeued
    2) buffer = D
    Dequeued
    Failed: attempted cqueue_front on empty queue.
    3) buffer = D  <-- should be same as last. wasn't updated.
    Failed: attempted cqueue_dequeue on empty queue.


*/
int main(int argc, char ** argv)
{
    uint8_t buffer;
    cqueue_init(&cq);

    cqueue_enqueue(cq,"A",1);
    cqueue_enqueue(cq,"B",1);
    cqueue_enqueue(cq,"C",1);
    cqueue_enqueue(cq,"D",1);

    cqueue_front(cq,&buffer,1);
    printf("0) buffer = %c\n",buffer);
    cqueue_dequeue(cq);
    cqueue_front(cq,&buffer,1);
    printf("1) buffer = %c\n",buffer);
    cqueue_dequeue(cq);
    cqueue_front(cq,&buffer,1);
    printf("2) buffer = %c\n",buffer);
    cqueue_dequeue(cq);
    cqueue_front(cq,&buffer,1);
    printf("3) buffer = %c  <-- should be same as last. wasn't updated.\n",buffer);
    cqueue_dequeue(cq);
    int a = 42;
    return 0;
}
