#include <stdio.h>
#include <cuda.h>
#define N 100

__global__ void func(int* a){
	a[threadIdx.x] = threadIdx.x * threadIdx.x;
}

int main(){
	int a[N], *da;
	
	cudaMalloc(&da, N*sizeof(int));
	func<<<1, N>>>(da);
	//cudaDeviceSynchronize(); // This doesn't matter since cudaMemcpy Synchronizes
	
	cudaMemcpy(a, da, N*sizeof(int), cudaMemcpyDeviceToHost);
	
	for(int i = 0; i<N; i++){
		printf("%d\n", a[i]);
	}
	return 0;
}
