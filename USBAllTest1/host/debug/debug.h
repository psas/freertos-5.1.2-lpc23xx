#ifndef DEBUG_H
#define DEBUG_H
    //#define DEBUG

    #ifdef DEBUG
        #define PRINT_DEBUG(format, args...) printf(format, ##args);
    #else
        #define PRINT_DEBUG(format, args...)
    #endif
#endif

