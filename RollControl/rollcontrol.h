
#ifndef ROLLCONTROL_H_
#define ROLLCONTROL_H_

struct data_sample {
	int32_t gyro_reading;
	int32_t adc_reading;
};

#define DATA_SAMPLE_INITIALIZER  (struct data_sample) {.gyro_reading = 0, .adc_reading = 0}

enum {
	A_BUFFER,
	B_BUFFER
};


#endif /* ROLLCONTROL_H_ */
