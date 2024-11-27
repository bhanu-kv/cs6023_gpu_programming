#include <stdio.h>
#include <cuda.h>
#include <iostream>
#include <fstream>

__global__ void dkernel_square(int *arr, int N){
	unsigned id = threadIdx.x;
	
	if (id < N){
		arr[id] = id*id;
	}
}

__global__ void dkernel_cube(int *arr, int N){
	unsigned id = threadIdx.x;
	
	if (id < N){
		arr[id] = id*id*id;
	}
}

int main(){
	ifstream read_file("homework_numbers.txt");
	assert(read_file.is_open());
	
	int* arr_x, gpuarr_x;
	
	int N = 0;
	while(!read_file.eof())
	{
		read_file >> arr_x[i];
		N++;
	}
	
	read_file.close();
	
	cudaMalloc(&gpuarr_x, sizeof(int) * N);
	cudaMemcpy(gpuarr_x, arr_x, sizeof(int) * N, cudaMemcpyHostToDevice);
	dkernel<<<1, N>>>(gpuarr_x, N);
	
	cudaMemcpy(arr_x, gpuarr_x, sizeof(int) * N, cudaMemcpyDeviceToHost);
	
	ifstream read_file("homework_numbers.txt");
	assert(read_file.is_open());
	
	int* arr_y, gpuarr_y;
	
	int M = 0;
	while(!read_file.eof())
	{
		read_file >> arr_y[i];
		M++;
	}
	
	read_file.close();
	
	cudaMalloc(&gpuarr_y, sizeof(int) * M);
	cudaMemcpy(gpuarr_y, arr_y, sizeof(int) * M, cudaMemcpyHostToDevice);
	dkernel<<<1, N>>>(gpuarr_y, M);
	
	cudaMemcpy(arr_y, gpuarr_y, sizeof(int) * M, cudaMemcpyDeviceToHost);
	
	return 0;
}
