This folder contains classical (nonparametric) spectral estimation methods.  
The input data are generated as additive white Gaussian noise for the purpose of estimates.

## 1. Periodogram
The spectrum is computed from the FFT of the signal. This method causes fluctuations.

![periodogramFigure](https://user-images.githubusercontent.com/42914736/133318238-612457b3-1786-40ad-b1ea-219b621a4c16.png)


## 2. Welch method
Split input signal in to L blocks, compute the spectrum( also use FFT) for each block and take the average. 
Data block may overlap by up to 50% to take full use of data near block edge.
A window function is applied to each block to smooth the spectral and reduce the leakage.  

I used the Matlab function:  
pwelch(x,window,noverlap,nfft)   

usage:  
[Sxx,f]=pwelch(x,hanning(M),M/2,M); % Welch estimate; 


![spectrum_welchFigure](https://user-images.githubusercontent.com/42914736/133318271-c7b8b63e-d1cd-4010-b529-03cc8a9c4548.png)

Note: There is a tradeoff to choose the variance and resolution you want by choosing the number of divided blocks.   
Increase L-> the variance gets better, but the resolution is worse, and vice versa.

We can see the Welch method provide clear spectral, less fluctuating.

