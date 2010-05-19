#ifndef PWM_H_
#define PWM_H_

#include "FreeRTOS.h"
#include "lpc23xx.h"
#include <stdint.h>
#include <stdbool.h>


enum PWM_Channel {PWM1_0=0, PWM1_1=1, PWM1_2=2, PWM1_3=3, PWM1_4=4, PWM1_5=5, PWM1_6=6};

void setPWMMatchReg(const enum PWM_Channel chan, const bool interupt, const bool reset, const bool stop);
void setPWMDutyCycle(const enum PWM_Channel chan, const uint32_t dutyCycleTicks);
void setupPWMChannel(const enum PWM_Channel chan, const uint32_t dutyCycle);
void PWMinit (const uint32_t prescalar, const uint32_t periodTicks);
void setupPWMPinSetup2378(const enum PWM_Channel chan);
void setupPWMChannelPeripheral(const enum PWM_Channel chan, const uint32_t dutyCycle);


#endif /*PWM_H_*/
