#include "cqueue.h"

struct cqueue *cq;

int main(int argc, char ** argv)
{
    uint8_t buffer;
    cqueue_init(&cq);

    cqueue_enqueue(cq,"A",1);
    cqueue_enqueue(cq,"B",1);
    cqueue_enqueue(cq,"C",1);

    cqueue_front(cq,&buffer,1);
    cqueue_dequeue(cq);
    cqueue_front(cq,&buffer,1);
    cqueue_dequeue(cq);
    cqueue_front(cq,&buffer,1);
    cqueue_dequeue(cq);
    int a = 42;
    return 0;
}
