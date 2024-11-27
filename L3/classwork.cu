#include <stdio.h>
#include <cuda.h>

__global__ void dkernel1(int *gpuarr, int N){
	unsigned id = threadIdx.x;
	
	if (id < N){
		gpuarr[id] = 0;
	}
}

__global__ void dkernel2(int *gpuarr, int N){
	unsigned id = threadIdx.x;
	
	if (id < N){
		gpuarr[id] += id;
	}
}

int main(){
	int N = 8000;
	int a[N], *gpuarr;
	
	cudaMalloc(&gpuarr, sizeof(int) * N);
	dkernel1<<<1, N>>>(gpuarr, N);
	cudaDeviceSynchronize();
	
	dkernel2<<<1, N>>>(gpuarr, N);
	
	cudaMemcpy(a, gpuarr, sizeof(int) * N, cudaMemcpyDeviceToHost);
	
	for(int i = 0; i < N; i++){
		printf("%d\n", a[i]);
	}
	
	return 0;
}
