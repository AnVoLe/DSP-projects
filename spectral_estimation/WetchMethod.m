% EE254, Adaptive DSP
% student: An Vo
% Estimation of the Power Spectrum : The Welch Estimator
% --------------------------------------------------------------------
clear, clf
N=1024;
x=randn(size([1:N]')); % WGN
%
loop=0;
for M=[32 64 128 256];
    loop=loop+1;
    [Sxx,f]=pwelch(x,hanning(M),M/2,M); % Welch estimate;
    subplot(2,2,loop), plot(f/2,Sxx(:,1),'x',f/2,Sxx(:,1),'-')
    axis([0 0.5 0 2]);
    xlabel('Frquency f = F(Hz)/F_s(Hz)'),ylabel('Sxx-hat(f)'),
    title(sprintf('N = %d, M= %d, L= %d',N, M, N/M))
    Sxx=[];
end