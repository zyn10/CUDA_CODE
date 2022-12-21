
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include<iostream>
using namespace std;


// Hello world in CUDA world 

/*

__global__ void mykernel(void)
{
	printf("Hello this is GEFORECE GTX 1650 \n");
}
int main(void)
{
	mykernel <<<1,1>>> ();
	cudaDeviceSynchronize();
	printf("Hello this is Intel i5 10 Gen \n");
	return 0;
}


*/



// Add two numbers in cuda world


/*
__global__ void add(int* a, int* b, int* c)
{
	*c = *a + *b;
}

int main(void)
{
	int a, b, c;
	int* d_a, * d_b, * d_c;
	int size = sizeof(int);
	cudaMalloc((void**)&d_a, size);
	cudaMalloc((void**)&d_b, size);
	cudaMalloc((void**)&d_c, size);
	a = 2;
	b = 3;
	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, &c, size, cudaMemcpyHostToDevice);
	add <<<1, 1 >>> (d_a, d_b, d_c);
	cudaDeviceSynchronize();
	cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);
	printf("%d",c);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	return 0;
}


*/



// Vector Addition 


 
__global__ void add(int* a, int* b, int* c) {
	c[threadIdx.x] = a[threadIdx.x] / b[threadIdx.x];
}



void random_ints(int* a, int N)
{
	int i;
	for (i = 0; i < N; ++i)
		a[i] = rand();
}

#define N 10000
int main(void) {
	int* a, * b, * c;
	int* d_a, * d_b, * d_c;
	int size = N * sizeof(int);
	cudaMalloc((void**)&d_a, size);
	cudaMalloc((void**)&d_b, size);
	cudaMalloc((void**)&d_c, size);
	a = (int*)malloc(size);
	random_ints(a, N);
	b = (int*)malloc(size);
	random_ints(b, N);
	c = (int*)malloc(size);
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	add <<<1,N >>> (d_a, d_b, d_c);
	cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);
	for (int i = 1 ; i < N; i++)
	{
		printf("%d\n", c[i] );
	}
	free(a); free(b); free(c);
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	return 0;
}





