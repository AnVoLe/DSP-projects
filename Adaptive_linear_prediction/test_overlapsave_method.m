% Theory
% 
% Overlap Save Method
% 
% In this method, the size of the input data blocks is N=L+M-1 and the DFTs and the IDFTs are of length L. Each Data Block consists of the 
% last M-1 data points of the previous block followed by L new data points to form a data sequence of length N=L+M-1.An N point DFT  is computed 
% for each data block. The impulse response of the FIR filter is increased in length by appending L-1 zeros and an N-point DFT of the sequence is 
% computed once and stored. The multiplication of the N-point DFTs for the mth block of data yields 
%                                                                    Ym(k)=h(k)Xm(k). 
% Since the data record is of length N, the first M-1 points of Ym(n)are corrupted by aliasing and must be discarded. The last L points of Ym(n) 
% are exactly the same as the result  from linear convolution. To avoid loss of data due to aliasing, the last M-1  points of each data record are
% saved and these points become the first M-1 data points of the subsequent record. To begin the processing, the first M-1 point of the first record
% is set to zero. The resulting data sequence from the IDFT are given where the first M-1 points are discarded due to aliasing and the remaining L 
% points constitute the desired result from the linear convolution. This segmentation of the input data and the fitting of the output data blocks together 
% form the output sequence.
clc;
clear all;
x=[1 2 3 4 5 6 7 8 9 10 11 12]; % 12 available data input. it will be divided into a block of L=4 data points

h=[1 2 4];  %filter taps

% Code to perform Convolution using Overlap Save Method
M=length(h);
L=4;
N=M+L-1;

nb=(length(x))/L; % number of blocks
hF=[h zeros(1,L-1)]; % extend h for fast computation
for k=1:nb
    xB(k,:)=x(((k-1)*L+1):k*L) % x data for each block 
    if k==1
        xF(k,:)=[zeros(1,M-1) xB(k,:)] % extended x data for first block, we only can add zeros.
    else 
        xF(k,:)=[xB(k-1,(L-M+2):L) xB(k,:)] % extended x data for other blocks        
    end
     yF(k,:)=ifft(fft(xF(k,:)).*fft(hF))% extended output
end
yB=yF(:,M:(L+M-1)) % output of the desired block





