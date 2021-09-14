% EE252, Adaptive DSP
% student: An Vo
% 2) Estimation of the Autocorrelation Function
% ------------------------------------------------------
clear, close all
N=1024; % N = size of all available data
x=randn(size([1:N]')); % X is WGN with zero-mean and unit varianvce
%X is WSS random process
M=21; % estimate rxx(m), 0 <= m <= M-1= 20(maximum correlation lag)

loop=0;
for N=[32 128 512 1024] % N= Number of data points taken to find autocorrelation
    loop=loop+1;
    for m=0:M-1
        rxx(m+1)=x(m+1:N)'*x(1:N-m); % Matlab indices start from 1
    end
    rxx=rxx/N; % the biased estimator
    subplot(2,2,loop), plot([0:M-1],rxx,'o'),grid
    axis([-1 M-1 -0.5 1.5]);
    xlabel('m'), ylabel('rxx-hat(m)'),
    title(sprintf('N= %d', N))
end
%title for the group of subplots
sgtitle('Estimated autocorrelation in different block sizes') 