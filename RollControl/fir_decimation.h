#ifndef FIR_DECIMATION_H_
#define FIR_DECIMATION_H_

#include "fixed_point.h"


#define TAPS 16
#define DIVIDE 10

void initialize_fir_filter(void);
fp_base_type_t decimate(fp_base_type_t samples[DIVIDE]);

#endif /* FIR_DECIMATION_H_ */
