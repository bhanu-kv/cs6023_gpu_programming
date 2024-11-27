#include <stdio.h>
#include <cuda.h>

__global__ void dkernel(char *arr, int arrlen){
	unsigned id = threadIdx.x;
	
	// make sure only correct threads i.e. correct memory location is updated
	if (id < arrlen){
		++arr[id];
	}
}

int main(){
	// Assigning a pointer to gpu array
	char cpuarr[] = "Gdkkn\x1fVnqkc-", *gpuarr;
	
	// Assigns memory to gpu array and copy cpu string to gpu
	cudaMalloc(&gpuarr, sizeof(char) * (1 + strlen(cpuarr)));
	cudaMemcpy(gpuarr, cpuarr, sizeof(char) * (1 + strlen(cpuarr)), cudaMemcpyHostToDevice);
	
	// Run kernel to change gpu string
	dkernel<<<1, 32>>>(gpuarr, strlen(cpuarr));
	
	// Synchronization not needed before memcpy
	cudaDeviceSynchronize();
	
	// Copy gpu array to cpu and print
	cudaMemcpy(cpuarr, gpuarr, sizeof(char) * (1 + strlen(cpuarr)), cudaMemcpyDeviceToHost);
	printf("%s", cpuarr);
	
	return 0;
}
