#include "list.h"
#include <stdio.h>
#include <stdlib.h>

struct MyStruct
{
    int a;
};
int main(int argc, char ** argv)
{
    struct list *l = NULL;
    int size;
    int ret;
    struct MyStruct out;
    struct MyStruct *in;
    out.a=0;

    list_init(&l);


    for (int u = 0;u < 4;u++){
        struct MyStruct *newStruct = malloc(sizeof(struct MyStruct));
        newStruct->a = u;
        list_push_back(l,newStruct, sizeof(struct MyStruct));
    }

    for (int u = 0;u < 4;u++){
        struct MyStruct *aStruct;
        if (!list_front(l,(void**)&aStruct,sizeof(struct MyStruct))){
            printf("%i) aStruct->a=%i\n",u,aStruct->a);
            list_pop_front(l);
            free(aStruct);
        }
    }
    return 0;
}




