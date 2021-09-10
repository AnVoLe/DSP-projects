#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(x,y) ((x>y)?x:y)

static void decimate_by_2 (double *in_samples, int out_sample_count,double *out_samples);
static void downsample_by_2 (double *in_samples, int in_sample_count,double *h_coeffs, int h_count,double *out_samples,int out_samples_count);
static void my_convolution (double *in_samples, int in_sample_count,double *filter_coeffs, int filter_coeffs_count,double *out_samples,int out_sample_count);

int main()
{

// define input array
    double inputArr[]={0.1,0.5,0.3,-0.4};
    size_t in_sample_count = sizeof(inputArr) / sizeof(double);

// define filter
    double filter_coeffs[]={-0.01452123, -0.0155227 ,  0.01667252,  0.01800633, -0.01957209, -0.0214361 ,
                            0.02369253,  0.02647989, -0.03001054, -0.03462755, 0.04092347,  0.05001757,
                            -0.06430831, -0.09003163,  0.15005272, 0.45015816,  0.45015816,  0.15005272,
                            -0.09003163, -0.06430831, 0.05001757,  0.04092347, -0.03462755, -0.03001054,
                            0.02647989, 0.02369253, -0.0214361 , -0.01957209,  0.01800633,  0.01667252,  -0.0155227 , -0.01452123};
    size_t filter_order = sizeof(filter_coeffs) / sizeof(double);

// define a output of down-sample array
    int out_downsample_count=(MAX(in_sample_count,filter_order)+1)/2;
    double out_downsample_Arr[out_downsample_count];

// find the down-sample array output
    downsample_by_2 (inputArr, in_sample_count,filter_coeffs, filter_order,out_downsample_Arr,out_downsample_count);

    return 0;
}

/**This function finds convolution of two discrete signals using the table method.
The output size is the maximum of input samples sizes or filter orders.
**/
static void my_convolution (double *x_samples, int x_count,double *h_coeffs, int h_count,double *y_samples,int y_count)
{
    //define the part of vector x overlaps within the vector h
    double x_overlap[h_count];
    memset(x_overlap, 0, h_count* sizeof(double));

    //for loop to find output values for each index.
    for(int i=0;i<y_count;i++)
    {
        //find the 1st element of the vector x_overlap.if i<= length of x, the 1st element is updated as x(i). else, the 1st element is updated as 0.
        if(i<x_count) x_overlap[0]=x_samples[i];
        else x_overlap[0]=0;

        //find the convolution result at the index i.
        for(int j=0;j<h_count;j++)
        {
            y_samples[i]+=x_overlap[j]*h_coeffs[j];
        }

        //shift the 2nd -> end elements of the vector x_overlap to find the next output value.
        for(int j=h_count-1;j>0;j--)
        {
            x_overlap[j]=x_overlap[j-1];
        }

    }
}

/**This function removes a half number of the samples.
**/
static void decimate_by_2 (double *in_samples, int out_sample_count,double *out_samples)
{
    for(int i=0;i<out_sample_count;i++)
    {
        *out_samples = *in_samples;
        out_samples += 1;
        in_samples +=2;
    }
}

/**This function filter first and removes a half of number of samples.
**/
static void downsample_by_2 (double *in_samples, int in_sample_count,double *h_coeffs, int h_count,double *out_samples,int out_samples_count)
{
    // define the output of convolution array
    int out_conv_count=MAX(in_sample_count,h_count);
    double out_conv_Arr[out_conv_count];

/**First do the filtering**/
    my_convolution(in_samples,in_sample_count,h_coeffs,h_count,out_conv_Arr,out_conv_count);

/**Second find the decimate**/
    decimate_by_2(out_conv_Arr,out_samples_count,out_samples);

}
