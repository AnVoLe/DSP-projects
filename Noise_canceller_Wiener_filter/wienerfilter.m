% 1- FIR Wiener Filter
% -------------------------
clear, close all
% Generate AR(1) desired signal d(n).
sigma_sq_w=0.64;
b=[1];
a=[1 -0.6];
L1=100;
L2=200;
d=arma(sigma_sq_w, a,b,L1,L2); % desired signal;
d=d';
n=[0:L1-1]'; % Sample number
%
% Add a WGN vector v to d
sigma_sq_v=1;
v=sqrt(sigma_sq_v)*randn(size(d)); % WGN of variance sigma_sq_v
x=d+v; % "Measured" noisy signal
%
% Experiment with filter order M = 1, 2, 3, ...etc.
M=16;
% Compute cross-correlation vector rxd and correlation matrix R.
k=[0:M]';
rdd=(0.6).^k; % see lecture results for rdd(k)
rxd=rdd; % d and v are uncorrelated

rxx(1)=rdd(1)+sigma_sq_v; % rxx(0)=rdd(0)+sigma_sq_v
rxx(2:M+1)=rdd(2:M+1); % rxx(k)=rdd(k) for all k>0 
% because autocorrelation of v is diract pusle at m=0 only

R=toeplitz(rxx); % when in Matlab, type help Toeplitz
ho=R\rxd % solve for optimal filter coefficients
y=filter(ho,1,x); % filter noisy signal
e=d-y; % error signal
J_hat=std(e)^2 % estimate the MSE from e
J_min=rdd(1)-ho'*rxd % class result for min MSE

% plot the results
subplot(2,1,1),plot(n,d,'-',n,x,'+',n,y,'--')
xlabel('Sample, n'), ylabel('signal'),
title('FIR Wiener Filter, d(n) solid, x(n) pluses, y(n) dashed')

%
% 2- Causal IIR Wiener Filter
% ------------------------
aa=[1 -1/3]; % From class results:
bb=[4/9];
yy=filter(bb,aa,x); % apply Wiener filter
ee=d-yy; % corresponding error signal
J_hat=std(ee)^2 % estimate of MSE
% J_min=0.444; % statistical min; see class note
% plot the results
subplot(2,1,2),plot(n,d,'-',n,x,'+',n,yy,'--')
xlabel('Sample, n'), ylabel('signal'),
title('IIR Wiener Filter, d(n) solid, x(n) pluses, y(n) dashed')