#include <stdio.h>
#include <cuda.h>

// kernel which send instruction to gpu to parallely process it
__global__ void dkernel() {
	printf("Hello World.\n");
}

int main() {
	dkernel<<<1,1>>>();
//	Synchronizes CPU and GPU i.e. CPU doesn't continue with further code until GPU is done with processing all instructions.
//	cudaDeviceSynchronize();
	return 0;
}
