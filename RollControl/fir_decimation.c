#include "fir_decimation.h"


const static double b[TAPS] = { 0.0074662, 0.0109120, 0.0206629, 0.0354434, 0.0530993,
		0.0709415, 0.0861884, 0.0964305, 0.1000366, 0.0964305, 0.0861884,
		0.0709415, 0.0530993, 0.0354434, 0.0206629, 0.0109120, 0.0074662
};

static fp_base_type_t b_fixed[TAPS];

void initialize_fir_filter(void)
{
	for(int i = 0; i < TAPS; i++ ) {
		b_fixed[i] = double_to_fp_base_type_t(b[i]);
	}
}

// Feed each block of DIVIDE samples to this function; its return values
// comprise the decimated output.


// The newest sample should have index zero.
fp_base_type_t decimate(fp_base_type_t samples[DIVIDE])
{
	static fp_base_type_t regs[TAPS] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };

	// Advance the filter forward by DIVIDE steps.
	// We don't need to do the intermediate calculations because this is
	// FIR, not IIR.
	// This loop assumes DIVIDE * 2 >= TAPS, otherwise you have to do it
	// in the opposite order. (see memmove vs. memcpy)
	for ( int i = DIVIDE; i < TAPS; ++i ) {
		regs[i] = regs[i - DIVIDE];
	}

	// Insert the new samples.
	for ( int i = 0; i < DIVIDE; ++i ) {
		regs[i] = samples[i];
	}

	// Calculate the output sample.
	fp_base_type_t out = 0;
	for ( int i = 0; i < TAPS; ++i ) {
		//out += b[i] * regs[i];
		out += fp_mult(b[i], regs[i]);
	}

	return out;

}
