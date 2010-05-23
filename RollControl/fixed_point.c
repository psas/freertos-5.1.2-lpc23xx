#include "fixed_point.h"

#define RADIX_POINT_POSITION    16
#define FP_MAX  ((fp_base_type_t) 0x7fffffff)
#define FP_MIN  (-((fp_base_type_t) 1 << 31))

/*
#define pixman_max_fixed_48_16          ((pixman_fixed_48_16_t) 0x7fffffff)
#define pixman_min_fixed_48_16          (-((pixman_fixed_48_16_t) 1 << 31))
*/

fp_base_type_t double_to_fp_base_type_t(const double v)
{
	fp_base_type_t ret = (fp_base_type_t) ((double)(v * ((int32_t)(1<<RADIX_POINT_POSITION))));
	return(ret);
}

double fp_base_type_t_to_double(fp_base_type_t v)
{
	double ret = ((double) v) / ((double)((uint32_t)(1<<RADIX_POINT_POSITION)));
	return(ret);
}

fp_base_type_t fp_mult(const fp_base_type_t lhs, const fp_base_type_t rhs)
{
	//return(lhs * rhs);

	int64_t ret = ((int64_t) lhs) * ((int64_t) rhs);
	ret = (ret >> RADIX_POINT_POSITION);

	if( ret > FP_MAX ) {
		ret = FP_MAX;
	} else if( ret < FP_MIN ) {
		ret = FP_MIN;
	}

	return((fp_base_type_t) ret);

}

#define MATRIX_OFFSET_VAL(row_num, col_num, num_cols)     ((row_num * num_cols) + col_num)

int ft_matrix_mult_general(
			const fp_base_type_t *lhs_start, const uint8_t lhs_col_count, const uint8_t lhs_row_count,
			const fp_base_type_t *rhs_start, const uint8_t rhs_col_count, const uint8_t rhs_row_count,
			fp_base_type_t *out_start, const uint8_t out_col_count, const uint8_t out_row_count)
{
	if( lhs_col_count != rhs_row_count ) {
		return(-1);
	}
	if( lhs_row_count != out_row_count ) {
		return(-1);
	}
	if( rhs_col_count != out_row_count ) {
		return(-1);
	}


	for(int i = 0; i < lhs_row_count; i++ ) {
		fp_base_type_t sum = 0;
		for(int j = 0; j < rhs_col_count; j++ ) {
			for(int k = 0; k < lhs_col_count; k++ ) {
				out_start[MATRIX_OFFSET_VAL(i,j,out_col_count)] +=
						fp_mult(lhs_start[MATRIX_OFFSET_VAL(i,k,lhs_col_count)], rhs_start[MATRIX_OFFSET_VAL(k,j,rhs_col_count)]);
			}
		}
	}
}

struct fp_matrix_2x1_t  fp_matrix_mult_2x2_2x1(const struct fp_matrix_2x2_t lhs, const struct fp_matrix_2x1_t rhs)
{
	struct fp_matrix_2x1_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 2, 2,
				&rhs.m[0][0], 2, 1,
				&out.m[0][0], 2, 1);

	return(out);
}

struct fp_matrix_2x2_t  fp_matrix_mult_2x2_2x2(const struct fp_matrix_2x2_t lhs, const struct fp_matrix_2x2_t rhs)
{
	struct fp_matrix_2x2_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 2, 2,
				&rhs.m[0][0], 2, 2,
				&out.m[0][0], 2, 2);

	return(out);
}

struct fp_matrix_1x2_t  fp_matrix_mult_1x2_2x2(const struct fp_matrix_1x2_t lhs, const struct fp_matrix_2x2_t rhs)
{
	struct fp_matrix_1x2_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 1, 2,
				&rhs.m[0][0], 2, 2,
				&out.m[0][0], 1, 2);

	return(out);
}

struct fp_matrix_1x1_t  fp_matrix_mult_1x2_2x1(const struct fp_matrix_1x2_t lhs, const struct fp_matrix_2x1_t rhs)
{
	struct fp_matrix_1x1_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 1, 2,
				&rhs.m[0][0], 2, 1,
				&out.m[0][0], 1, 1);

	return(out);
}

struct fp_matrix_1x1_t  fp_matrix_mult_1x3_3x1(const struct fp_matrix_1x3_t lhs, const struct fp_matrix_3x1_t rhs)
{
	struct fp_matrix_1x1_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 1, 3,
				&rhs.m[0][0], 3, 1,
				&out.m[0][0], 1, 1);

	return(out);
}

struct fp_matrix_2x1_t  fp_matrix_mult_2x3_3x1(const struct fp_matrix_2x3_t lhs, const struct fp_matrix_3x1_t rhs)
{
	struct fp_matrix_2x1_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 2, 3,
				&rhs.m[0][0], 3, 1,
				&out.m[0][0], 2, 1);

	return(out);
}

struct fp_matrix_3x3_t  fp_matrix_mult_3x3_3x3(const struct fp_matrix_3x3_t lhs, const struct fp_matrix_3x3_t rhs)
{
	struct fp_matrix_3x3_t out;
	memset(&out, 0, sizeof(out));

	ft_matrix_mult_general(
				&lhs.m[0][0], 3, 3,
				&rhs.m[0][0], 3, 3,
				&out.m[0][0], 3, 3);

	return(out);
}









//int main(int argc, char *argv[]) {
//
//	fp_base_type_t t1 = double_to_fp_base_type_t(1.2);
//	printf("t1 = %d\n", t1);
//
//
//	struct fp_matrix_2x2_t lhs;
//	struct fp_matrix_2x2_t rhs;
//
//	int cnt = 1;
//	for(int i = 0; i < 2; i++ ) {
//			for(int j = 0; j < 2; j++ ) {
//				lhs.m[i][j] = double_to_fp_base_type_t(cnt);
//				rhs.m[i][j] = double_to_fp_base_type_t(cnt);
//				printf("lhs.m[%d][%d] = %d\n", i,j,lhs.m[i][j]);
//				printf("rhs.m[%d][%d] = %d\n", i,j,rhs.m[i][j]);
//				cnt++;
//			}
//	}
//
//	struct fp_matrix_2x2_t r = fp_matrix_mult_2x2_2x2(lhs, rhs);
//
//	for(int i = 0; i < 2; i++ ) {
//		for(int j = 0; j < 2; j++ ) {
//			printf("out.m[%d][%d] = %f, %d\n", i, j, fp_base_type_t_to_double(r.m[i][j]), r.m[i][j]);
//		}
//	}
//
//
//	printf("3x3 mult 3x3 test\n");
//	struct fp_matrix_3x3_t lhs3;
//	struct fp_matrix_3x3_t rhs3;
//
//	cnt = 1;
//	for(int i = 0; i < 3; i++ ) {
//			for(int j = 0; j < 3; j++ ) {
//				lhs3.m[i][j] = double_to_fp_base_type_t(cnt);
//				rhs3.m[i][j] = double_to_fp_base_type_t(cnt);
//				cnt++;
//			}
//	}
//
//	struct fp_matrix_3x3_t r3 = fp_matrix_mult_3x3_3x3(lhs3, rhs3);
//
//	for(int i = 0; i < 3; i++ ) {
//		for(int j = 0; j < 3; j++ ) {
//			printf("out.m[%d][%d] = %f, %d\n", i, j, fp_base_type_t_to_double(r3.m[i][j]), r3.m[i][j]);
//		}
//	}
//
//	return(0);
//}




