#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

__global__ void addArrays(int* a, int* b, int* c) {
	
	int idx = threadIdx.x;
	c[idx] = a[idx] + b[idx];
}

int main()
{
	int h_a[] = { 10, 20, 30, 40, 50 };
	int h_b[] = { 9, 8, 7, 6, 5 };
	int h_c[5];

	int size = sizeof(int) * 5;
	int *da, *db, *dc;
	cudaMalloc((void**)&da, size);
	cudaMalloc((void**)&db, size);
	cudaMalloc((void**)&dc, size);
	
	cudaMemcpy(da, h_a, size, cudaMemcpyKind::cudaMemcpyHostToDevice);
	cudaMemcpy(db, h_b, size, cudaMemcpyKind::cudaMemcpyHostToDevice);

	addArrays <<<1, 5 >>> (da, db, dc);

	cudaMemcpy(h_c, dc, size, cudaMemcpyKind::cudaMemcpyDeviceToHost);

	
	for (int i = 0; i < 5; ++i) {
		std::cout << h_c[i] << std::endl;
	}

	return 0;
}
