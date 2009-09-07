

#include "i2c.h"

heartbeat() {

    int datawrite[1024];

i2cinit(I2C0);

// device id? blinkm 0x09 j
//

// write a register

I2CmasterTransmit(I2C0, deviceAddr, datawrite, 4);

}

