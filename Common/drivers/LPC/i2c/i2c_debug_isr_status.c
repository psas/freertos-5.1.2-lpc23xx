/*
 * i2c_debug_isr_status.c
 * send the state of the status register bits to gpio pins
 * This is configured for olimex 2378 evaluation board
 *
 * Earlier setup code will need to enable these io pins
 * or unknown behavior will result. For LPC2378 olimex:
 *  FIO1DIR |= (1<<19);
 *  FIO1DIR |= (1<<20);
 *  FIO1DIR |= (1<<22);
 *  FIO1DIR |= (1<<24);
 *  FIO1DIR |= (1<<25);
 *  FIO1DIR |= (1<<26);
 *  FIO1DIR |= (1<<27);
 *  FIO1DIR |= (1<<28);
 *  FIO1DIR |= (1<<31);
 *
 *
 */

        if(I2C0STAT & 1<<0) {
            FIO1SET = (1<<28);
        } else {
            FIO1CLR = (1<<28);
        }
        if(I2C0STAT & 1<<1) {
            FIO1SET = (1<<20);
        } else {
            FIO1CLR = (1<<20);
        }
        if(I2C0STAT & 1<<2) {
            FIO1SET = (1<<22);
        } else {
            FIO1CLR = (1<<22);
        }
        if(I2C0STAT & 1<<3) {
            FIO1SET = (1<<24);
        } else {
            FIO1CLR = (1<<24);
        }
        if(I2C0STAT & 1<<4) {
            FIO1SET = (1<<25);
        } else {
            FIO1CLR = (1<<25);
        }
        if(I2C0STAT & 1<<5) {
            FIO1SET = (1<<26);
        } else {
            FIO1CLR = (1<<26);
        }
        if(I2C0STAT & 1<<6) {
            FIO1SET = (1<<27);
        } else {
            FIO1CLR = (1<<27);
        }
        if(I2C0STAT & 1<<7) {
            FIO1SET = (1<<31);
        } else {
            FIO1CLR = (1<<31);
        }
