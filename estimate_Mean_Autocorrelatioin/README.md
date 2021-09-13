The input data are generated as additive Gaussian noise for the purpose of estimates.
## 1. Signal mean estimate
This program estimates the mean and std of available data interms of different block sizes. The figures of estimated mean and the table of standard deviation for each block size are shown.
Available data N=1024. There are 4 cases of the block size M=[8 32 128 256] in this program.
The results:

![figure1](https://user-images.githubusercontent.com/42914736/133139551-abd9bb94-8528-4ecd-8e91-ca3c4f9b6704.png)

Each row of the table below shows the estimated std and true std for each case of the block size 8,32,128,256:

![image](https://user-images.githubusercontent.com/42914736/133139741-6ab9335d-fd98-4d88-b38a-7a31445b2b5d.png)

we can see the the bigger block size, the smaller standard deviation and the mean is less fluctuating.

## 2. Signal autocorrelation estimate
This program estimates the auto correlation rxx(m) of available data interms of different block sizes. The process is considered WSS and I estimated rxx(m) for only 20 first terms.
The biased autocorrelation estimate is used: 
\hat{r}_{xx}(m)=\frac{1}{N}\sum_{n=0}^{N-|m|-1}{x(n).x(n+m)}

The result:

![figure_autocorrelation](https://user-images.githubusercontent.com/42914736/133143746-fb2bfd0d-bfec-4d37-8309-5a275f8b1d82.png)

we can see the the bigger block size, the autocorrelation is more likely a pulse at m=0 ( auto correlation of white noise).
