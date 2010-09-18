#ifndef list_H_
#define list_H_

#include <stdint.h>


/*
    Provides a persistant datastructure.
    
*/

struct list_element
{
    struct list_element   *next;
    struct list_element   *prev;
    void                  *data;
    int                size;
};

struct list
{
    struct list_element *front;
    struct list_element *back;
    int count;
};


int list_init (struct list **l);

int list_push_back (struct list *l, void *data, int size);
int list_back (struct list *l, void *data, int size);
int list_pop_back(struct list *l);

int list_push_front (struct list *l, void *data, int size);
int list_front (struct list *l, void **data, int size);
int list_pop_front (struct list *l);

int list_del(struct list *l, struct list_element *ele);
int list_get_at(struct list *l, int index, void **data, int size);
int list_count (struct list *l);


#endif

