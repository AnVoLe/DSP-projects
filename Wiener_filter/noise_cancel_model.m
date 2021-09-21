% Hayes Example 7.2.6, lecture slide 6, EE254
% Noise cancellation using Wiener Filter
% --------------------------------------
clear, close all
n1=[0:500]';
vn=randn(size(n1));

tmp=filter(1,[1 -0.8],vn); % generate 501 samples
v1n=tmp(301:500);       %keep only the last 200 (avoids transients)
tmp=filter(1,[1 0.6],vn);    % same for v2n
v2n=tmp(301:500);

w0=0.05*pi;
n=[0:199]';
sn=sin(w0*n);       % phi is any value between 0 and 2pi, phi=0 is chosen
dn=sn+v1n;      %noisy sinusoid;primary signal
xn=v2n;         %correlated noise; secondary signal

% estimate from the data rxx and rxd
N=length(xn);
rxx=xcorr(xn,xn)/N;     %biased correlation estimator
rxd=xcorr(xn,dn)/N;     %cross-correlation estimator

M=12;            % Wiener filter order
rxx=rxx(N:N+M); % extract rxx(0),rxx(1),...,rxx(M)
rxd=rxd(N:N+M); % extract rxd(0),rxd(1),...,rxd(M)
R=toeplitz(rxx); % correlation matrix
ho=R\rxd;       % solve for the Wiener filter coeffs

yn=filter(ho,1,xn); % filter xn through ho
en=dn-yn;       % en is the cleaned dn here

% plot results
subplot(3,1,1),plot(n,sn,'b',n,dn,'-r')
title(['Wiener Filter of order M=',num2str(M)])
subplot(3,1,2),plot(n,xn,'-b')
axis([0 200 -5 5])
subplot(3,1,3),plot(n,sn,'.b',n,en,'-r')
axis([0 200 -2 2])

