#include <stdio.h>
#include <cuda.h>
#define N 100
__global__ void func(){
	printf("%d\n", threadIdx.x * threadIdx.x);
}

int main(){
	func<<<1, N>>>();
	cudaDeviceSynchronize();
	return 0;
}
