#include <stdio.h>
#include <cuda.h>

__global__ void dkernel(){
	printf("Hello World.\n");
}

int main(){
//	prints 32 different Hello World which comes from 32 different threads
//	1 is the number of thread blocks that are being assigned
//	We can maximum assign 1024 threads according to the GPU limit on my PC
//	Number of thread blocks can be unlimited
//	If more number of thread blocks are assigned than available then the cores will be processed sequentially from built-in algorithm
	dkernel<<<1, 32>>>();
	cudaDeviceSynchronize();
	return 0;
}
