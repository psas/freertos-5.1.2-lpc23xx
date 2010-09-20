#ifndef DEBUG_H
#define DEBUG_H
    #ifdef INFO
        #define PRINT_INFO(format, args...) printf(format, ##args);
    #else
        #define PRINT_INFO(format, args...) 
    #endif

    #ifdef WARNING
        #define PRINT_WARNING(format, args...) printf(format, ##args);
    #else
        #define PRINT_WARNING(format, args...) 
    #endif

    #ifdef ERROR
        #define PRINT_ERROR(format, args...) printf(format, ##args);
    #else
        #define PRINT_ERROR(format, args...) 
    #endif    
    

#endif

