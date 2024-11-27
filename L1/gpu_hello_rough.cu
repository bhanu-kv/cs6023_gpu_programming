#include <stdio.h>
#include <cuda.h>

__global__ void dkernel1(){
	printf("Hello World 1.\n");
}

__global__ void dkernel2(){
	printf("Hello World 2.\n");
}

__global__ void dkernel3(){
	printf("Hello World 3.\n");
}
int main(){
	dkernel1<<<1, 1>>>();
	
	dkernel2<<<1, 1>>>();
	cudaDeviceSynchronize();
	
	dkernel3<<<1, 1>>>();
	cudaDeviceSynchronize();
	return 0;
}
