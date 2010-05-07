
#ifndef FIXED_POINT_H_
#define FIXED_POINT_H_

#include <stdint.h>
#include <string.h>
#include <stdio.h>

typedef int32_t fp_base_type_t;


fp_base_type_t fp_mult(const fp_base_type_t lhs, const fp_base_type_t rhs);

struct fp_matrix_1x1_t {
	fp_base_type_t  m[1][1];
};

struct fp_matrix_1x2_t {
	fp_base_type_t  m[1][2];
};

struct fp_matrix_1x3_t {
	fp_base_type_t  m[1][3];
};

struct fp_matrix_2x2_t {
	fp_base_type_t  m[2][2];
};
struct fp_matrix_2x3_t {
	fp_base_type_t  m[2][3];
};

struct fp_matrix_3x3_t {
	fp_base_type_t  m[3][3];
};

struct fp_matrix_3x1_t {
	fp_base_type_t  m[3][1];
};

struct fp_matrix_1x1_t  fp_matrix_mult_1x2_2x1(const struct fp_matrix_1x2_t lhs, const struct fp_matrix_2x1_t rhs);
struct fp_matrix_1x2_t  fp_matrix_mult_1x2_2x2(const struct fp_matrix_1x2_t lhs, const struct fp_matrix_2x2_t rhs);
struct fp_matrix_1x1_t  fp_matrix_mult_1x3_3x1(const struct fp_matrix_1x3_t lhs, const struct fp_matrix_3x1_t rhs);
struct fp_matrix_2x1_t  fp_matrix_mult_2x2_2x1(const struct fp_matrix_2x2_t lhs, const struct fp_matrix_2x1_t rhs);
struct fp_matrix_2x2_t  fp_matrix_mult_2x2_2x2(const struct fp_matrix_2x2_t lhs, const struct fp_matrix_2x2_t rhs);
struct fp_matrix_2x1_t  fp_matrix_mult_2x3_3x1(const struct fp_matrix_2x3_t lhs, const struct fp_matrix_3x1_t rhs);
struct fp_matrix_3x3_t  fp_matrix_mult_3x3_3x3(const struct fp_matrix_3x3_t lhs, const struct fp_matrix_3x3_t rhs);




#endif /* FIXED_POINT_H_ */
