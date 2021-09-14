% EE252, Adaptive DSP
% student: An Vo
% Estimation of the Power Spectrum : The Periodogram
% ---------------------------------------------------------------
clear, close all
N=1024;
x=randn(size([1:N]')); % X is WGN with zero-mean and unit varianvce
loop=0;
for N=[128 256 512 1024];
    loop=loop+1;
    X=fft(x(1:N),N);
    Sxx=X.*conj(X)/N; % periodogram estimate
    k=[0:N/2]'; % Only 0 <= F(Hz)/F_s(Hz) <= 0.5
    fk=k/N; % is plotted; k/N = F(Hz)/F_s(Hz)
    subplot(2,2,loop), plot(fk,Sxx(k+1),'-') % Matlab indices start from 1
    axis([0 0.5 0 5]);
    xlabel('Frquency f = F(Hz)/F_s(Hz)'),ylabel('Sxx-hat(f)'),
    title(sprintf('N = %d', N))
end

