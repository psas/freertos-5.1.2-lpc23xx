#include "list.h"
#include "debug.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/*
    Expected Output:

        3) ((struct MyStruct*)ele->data)->a=3
        2) ((struct MyStruct*)ele->data)->a=2
        1) ((struct MyStruct*)ele->data)->a=1
        0) ((struct MyStruct*)ele->data)->a=0
        ---
        0) aStruct->a=0
        1) aStruct->a=1
        2) aStruct->a=2
        3) aStruct->a=3
*/

#define MIN(x,y)   (x<=y)?x:y

int list_init (struct list **l)
{
    *l = (struct list*)malloc(sizeof(struct list));
    if (!*l){
        PRINT_DEBUG("list_init unable to allocate memory.\n");
        return -1;//NO MEM
    }

    (*l)->front=NULL;
    (*l)->back=NULL;
    (*l)->count=0;

    return 0;//Success
}

int list_push_back(struct list *l, void *data, int size)
{
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_push_back.\n");
        return -1;
    }
    struct list_element *new_element = (struct list_element*)malloc(sizeof(struct list_element));
    if (!new_element){
        PRINT_DEBUG("Failed: list_push_back failed to allocate memory.\n");
        return -2;
    }

    new_element->data = data;
    new_element->next = new_element->prev = NULL;

    if (!l->front){//empty list
        l->front = l->back = new_element;
    }else{//not empty
        l->back->next = new_element;
        new_element->prev = l->back;
        l->back = new_element;
    }  
    l->count++;
    return 0;
}

int list_back (struct list *l, void **data, int size)
{
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_back.\n");
        return -1;
    }
    if (!l->back){
        PRINT_DEBUG("Failed: list_back invoked on empty list.\n");
        return -2;
    }
    *data = l->back->data;
    int min = MIN(size,l->back->size);
    return min;
}

int list_pop_back(struct list *l)
{
    return -1;
}

int list_push_front (struct list *l, void *data, int size)
{
    return -1;
}

int list_front (struct list *l, void **data, int size)
{
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_front.\n");
        return -1;
    }
    if (!l->front){
        PRINT_DEBUG("Failed: list_front invoked on empty list.\n");
        return -2;
    }
    *data = l->front->data;
    int min = MIN(size,l->front->size);
    return min;
}

int list_pop_front(struct list *l)
{
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_pop_front.\n");
        return -1;
    }
    if (!l->front){
        PRINT_DEBUG("Failed: list_pop_front invoked on empty list.\n");
        return -2;
    }

    struct list_element *cur = l->front;
    l->front = l->front->next;
    if (l->front){        
        l->front->prev = NULL;
    }
    free(cur);

        
    l->count--;
    return 0;
}

int list_del(struct list *l, struct list_element *ele)
{    
    struct list_element *dove = ele;
    if (ele->prev){
        ele->prev->next = ele->next;
    }else{
        l->front = ele->next;
    }
    if (ele->next){
        ele->next->prev = ele->prev;
    }else{
        l->back = ele->prev;
    }
    free(dove);
    l->count--;
}

int list_get_at(struct list *l, int index, void **data, int size)
{
    int counter=0;
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_get_at.\n");
        return -1;
    }
    if (index < 0 || index > (l->count-1)){
        PRINT_DEBUG("Failed: index passed to list_get_at was out of bounds.\n");
        return -2;
    }

    struct list_element *cur = l->front;
    for(;cur;cur = cur->next){
        if (counter == index){
            break;
        }
        counter++;
    }
    *data = cur->data;
    int min = MIN(size,cur->size);
    return min;
}

int list_get(struct list *l, struct list_element **ele, void *data, int size)
{
    if (!l){
        PRINT_DEBUG("Failed: passed a NULL list pointer to list_get_at.\n");
        return -1;
    }
    if (!ele){
        PRINT_DEBUG("Failed: ele passed to list_get is NULL.\n");
        return -2;
    }
    struct list_element *cur = l->front;
    for(;cur;cur = cur->next){
        if (cur->data == data){
            *ele = cur;
            return 1;
        }
    }
    return 0;
}

int list_count (struct list *l)
{
    return l->count;
}
