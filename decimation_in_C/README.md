This program does decimation an input sample which includes filtering process( convolution) and down-sampling.
I have written this program in both C and MATLAB. MATLAB is in another folder. I wrote all my own functions including decimate_by_2, downsample_by_2 and my_convolution.
In this C program: 
decimate_by_2 is downsample_by_2
downsample_by_2 is decimate_by_2
just a misunderstood at the begining.

•	Given the audio samples and filter coefficients:

![image](https://user-images.githubusercontent.com/42914736/132569567-395323fa-8f9a-4904-b3f6-d1c7d58df71b.png)

•	Output downsample(decimata actually) array:

![image](https://user-images.githubusercontent.com/42914736/132569615-c1e8e679-683d-4cdc-a1d0-f8e58952ae63.png)
