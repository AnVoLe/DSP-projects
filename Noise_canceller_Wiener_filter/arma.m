function x=arma(sigma_sq, a, b, L1, L2)
% ARMA Autoregressive-Moving Average Signal Model
% arma(sigma_sq, a, b) returns an L x 1 arma vector x
% by filtering white gauassian noise of variance sigma_sq
% through a digital filter of numerator coefficients "b"
% and denomenator coefficients "a". The first 100 samples
% of the generated vector are discarded to minimize transient
% effects
% Input: sigma_sq variance of white gaussian noise input
% a row vector; denomenator filter coefficients
% b col vector; numerator filter coefficients
% L1 Length of returned ARMA vector
% L2 Number of samples to be discarded
%
L=L1+L2;
x=sqrt(sigma_sq)*randn(size([1:L])); % WGN variance = sigma_sq
x=filter(b,a,x); % type help filter
x=x(L2+1:L); % Discard the first L2 samples
end