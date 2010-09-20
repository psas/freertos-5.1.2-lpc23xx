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
    list_init(&l);

    struct MyStruct *newStruct[4];

    for (int u = 0;u < 4;u++){
        newStruct[u] = malloc(sizeof(struct MyStruct));
        newStruct[u]->a = u;
        list_push_back(l,newStruct[u], sizeof(struct MyStruct));
    }

    for (int u = 3;u >= 0;u--){
        struct MyStruct *aStruct=NULL;
        struct list_element *ele;
        list_get(l,&ele, newStruct[u],sizeof(struct MyStruct));
        printf("%i) ((struct MyStruct*)ele->data)->a=%i\n",u,((struct MyStruct*)ele->data)->a);
    }

    list_get(l,NULL, newStruct[0],sizeof(struct MyStruct));//Cause an error

    printf("---\n");
    for (int u = 0;u < 4;u++){
        struct MyStruct *aStruct=NULL;
        if (!list_front(l,(void**)&aStruct,sizeof(struct MyStruct))){
            printf("%i) aStruct->a=%i\n",u,aStruct->a);
            list_pop_front(l);
            free(aStruct);
        }
    }
    list_front(l,NULL,0); //Cause a warning
    return 0;
}




